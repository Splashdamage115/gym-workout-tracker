// API Base URL
const API_URL = '/api';

// State
let token = localStorage.getItem('token');
let currentUser = JSON.parse(localStorage.getItem('user') || 'null');

// DOM Elements
const authSection = document.getElementById('auth-section');
const appSection = document.getElementById('app-section');
const loginForm = document.getElementById('login-form');
const registerForm = document.getElementById('register-form');
const showRegisterBtn = document.getElementById('show-register');
const showLoginBtn = document.getElementById('show-login');
const messageDiv = document.getElementById('message');

// Initialize app
document.addEventListener('DOMContentLoaded', () => {
  if (token && currentUser) {
    showApp();
    loadWorkouts();
  } else {
    showAuth();
  }

  // Event Listeners
  document.getElementById('loginForm').addEventListener('submit', handleLogin);
  document.getElementById('registerForm').addEventListener('submit', handleRegister);
  document.getElementById('workoutForm').addEventListener('submit', handleAddWorkout);
  document.getElementById('logout-btn').addEventListener('click', handleLogout);
  
  showRegisterBtn.addEventListener('click', (e) => {
    e.preventDefault();
    loginForm.classList.add('hidden');
    registerForm.classList.remove('hidden');
  });

  showLoginBtn.addEventListener('click', (e) => {
    e.preventDefault();
    registerForm.classList.add('hidden');
    loginForm.classList.remove('hidden');
  });
});

// Show/Hide sections
function showAuth() {
  authSection.classList.remove('hidden');
  appSection.classList.add('hidden');
}

function showApp() {
  authSection.classList.add('hidden');
  appSection.classList.remove('hidden');
  document.getElementById('username-display').textContent = `Welcome, ${currentUser.username}!`;
  
  // Set today's date as default
  const today = new Date().toISOString().split('T')[0];
  document.getElementById('workout-date').value = today;
}

// Message Display
function showMessage(text, type = 'success') {
  messageDiv.textContent = text;
  messageDiv.className = `message ${type}`;
  messageDiv.classList.remove('hidden');

  setTimeout(() => {
    messageDiv.classList.add('hidden');
  }, 3000);
}

// Authentication Functions
async function handleLogin(e) {
  e.preventDefault();

  const username = document.getElementById('login-username').value;
  const password = document.getElementById('login-password').value;

  try {
    const response = await fetch(`${API_URL}/auth/login`, {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({ username, password })
    });

    const data = await response.json();

    if (!response.ok) {
      throw new Error(data.error || 'Login failed');
    }

    token = data.token;
    currentUser = data.user;
    localStorage.setItem('token', token);
    localStorage.setItem('user', JSON.stringify(currentUser));

    showMessage('Login successful!');
    showApp();
    loadWorkouts();

    // Clear form
    e.target.reset();
  } catch (error) {
    showMessage(error.message, 'error');
  }
}

async function handleRegister(e) {
  e.preventDefault();

  const username = document.getElementById('register-username').value;
  const email = document.getElementById('register-email').value;
  const password = document.getElementById('register-password').value;

  try {
    const response = await fetch(`${API_URL}/auth/register`, {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({ username, email, password })
    });

    const data = await response.json();

    if (!response.ok) {
      throw new Error(data.error || 'Registration failed');
    }

    showMessage('Registration successful! Please login.');
    
    // Switch to login form
    registerForm.classList.add('hidden');
    loginForm.classList.remove('hidden');

    // Clear form
    e.target.reset();
  } catch (error) {
    showMessage(error.message, 'error');
  }
}

function handleLogout() {
  token = null;
  currentUser = null;
  localStorage.removeItem('token');
  localStorage.removeItem('user');
  
  showMessage('Logged out successfully');
  showAuth();

  // Clear forms
  document.getElementById('loginForm').reset();
  document.getElementById('workoutForm').reset();
  document.getElementById('workouts-container').innerHTML = '';
}

// Workout Functions
async function handleAddWorkout(e) {
  e.preventDefault();

  const workoutData = {
    exercise_name: document.getElementById('exercise-name').value,
    sets: document.getElementById('sets').value || null,
    reps: document.getElementById('reps').value || null,
    weight: document.getElementById('weight').value || null,
    duration: document.getElementById('duration').value || null,
    notes: document.getElementById('notes').value || null,
    workout_date: document.getElementById('workout-date').value
  };

  try {
    const response = await fetch(`${API_URL}/workouts`, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        'Authorization': `Bearer ${token}`
      },
      body: JSON.stringify(workoutData)
    });

    const data = await response.json();

    if (!response.ok) {
      throw new Error(data.error || 'Failed to add workout');
    }

    showMessage('Workout logged successfully!');
    
    // Clear form
    e.target.reset();
    const today = new Date().toISOString().split('T')[0];
    document.getElementById('workout-date').value = today;

    // Reload workouts
    loadWorkouts();
  } catch (error) {
    showMessage(error.message, 'error');
  }
}

async function loadWorkouts() {
  try {
    const response = await fetch(`${API_URL}/workouts`, {
      headers: {
        'Authorization': `Bearer ${token}`
      }
    });

    const data = await response.json();

    if (!response.ok) {
      throw new Error(data.error || 'Failed to load workouts');
    }

    displayWorkouts(data.workouts);
  } catch (error) {
    showMessage(error.message, 'error');
  }
}

function displayWorkouts(workouts) {
  const container = document.getElementById('workouts-container');

  if (workouts.length === 0) {
    container.innerHTML = '<div class="empty-state">No workouts logged yet. Start by adding your first workout!</div>';
    return;
  }

  container.innerHTML = workouts.map(workout => {
    const date = new Date(workout.workout_date).toLocaleDateString('en-US', {
      year: 'numeric',
      month: 'short',
      day: 'numeric'
    });

    return `
      <div class="workout-card">
        <div class="workout-header">
          <h3>${escapeHtml(workout.exercise_name)}</h3>
          <span class="workout-date">${date}</span>
        </div>
        <div class="workout-details">
          ${workout.sets ? `<div class="workout-detail"><strong>Sets:</strong> ${workout.sets}</div>` : ''}
          ${workout.reps ? `<div class="workout-detail"><strong>Reps:</strong> ${workout.reps}</div>` : ''}
          ${workout.weight ? `<div class="workout-detail"><strong>Weight:</strong> ${workout.weight} lbs</div>` : ''}
          ${workout.duration ? `<div class="workout-detail"><strong>Duration:</strong> ${workout.duration} min</div>` : ''}
        </div>
        ${workout.notes ? `<div class="workout-notes">Notes: ${escapeHtml(workout.notes)}</div>` : ''}
        <div class="workout-actions">
          <button class="btn-delete" data-workout-id="${workout.id}">Delete</button>
        </div>
      </div>
    `;
  }).join('');

  // Attach event listeners to delete buttons
  container.querySelectorAll('.btn-delete').forEach(button => {
    button.addEventListener('click', () => {
      const workoutId = parseInt(button.getAttribute('data-workout-id'));
      deleteWorkout(workoutId);
    });
  });
}

// Escape HTML to prevent XSS
function escapeHtml(text) {
  const div = document.createElement('div');
  div.textContent = text;
  return div.innerHTML;
}

async function deleteWorkout(id) {
  if (!confirm('Are you sure you want to delete this workout?')) {
    return;
  }

  try {
    const response = await fetch(`${API_URL}/workouts/${id}`, {
      method: 'DELETE',
      headers: {
        'Authorization': `Bearer ${token}`
      }
    });

    const data = await response.json();

    if (!response.ok) {
      throw new Error(data.error || 'Failed to delete workout');
    }

    showMessage('Workout deleted successfully!');
    loadWorkouts();
  } catch (error) {
    showMessage(error.message, 'error');
  }
}
