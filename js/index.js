const inputBox = document.getElementById("input-box");
const listContainer = document.getElementById("list-container");
let editMode = false; // Variable to track edit mode


var firebaseConfig = {
  // Replace with your own Firebase configuration
  apiKey: "AIzaSyAEZXIpmALUy-VhBPD15pEoR3DQsYuXR-I",
  authDomain: "sample-fd33f.firebaseapp.com",
  projectId: "sample-fd33f",
  storageBucket: "sample-fd33f.appspot.com",
  messagingSenderId: "780264166253",
  appId: "1:780264166253:web:2c6cd0ec831505e82e4064",
  databaseURL: "https://sample-fd33f-default-rtdb.firebaseio.com"
};

firebase.initializeApp(firebaseConfig);

    // Get a reference to the Firebase Realtime Database
var db = firebase.database();

var tasksRef = db.ref().child("tasks");

function handleKeyPress(event) {
  if (event.keyCode === 13) {
      event.preventDefault(); // Prevent form submission
      addTask();
  }
}

function addTask() {
  if (inputBox.value === '') {
    alert("You must write something!");
    return; // Exit the function if input is empty
  }

  const task = document.createElement("div");
  task.className = "task";
  var text = document.getElementById("input-box").value;

  var newKey = db.ref().push().key;

  // Create a new data object
  var newData = {
    text: text
  };

  // Save the new data to the database
  db.ref('texts/' + newKey).set(newData)
    // .then(function() {
    //   alert("Text saved successfully!");
    //   document.getElementById("textInput").value = "";
    // })
    // .catch(function(error) {
    //   alert("Error saving text: " + error);
    // });

  const li = document.createElement("li");
  li.textContent = escapeHTML(inputBox.value);

  const checkbox = document.createElement("input");
  checkbox.type = "checkbox";
  checkbox.addEventListener("change", toggleTaskCompletion);

  li.addEventListener("click", function() {
    if (!editMode) {
      enableEditMode(li);
    }
  });

  const editButton = document.createElement("i");
  editButton.classList.add("fa-solid", "fa-pen-to-square");
  editButton.addEventListener("click", function() {
    if (!editMode) {
      enableEditMode(li);
    } else {
      disableEditMode(li);
    }
    editMode = !editMode;
  });

  const deleteButton = document.createElement("i");
  deleteButton.classList.add("fa-regular", "fa-trash-can");
  deleteButton.addEventListener("click", function() {
    const confirmation = confirm("Are you sure?");
    if (confirmation) {
      task.remove();
    }
  });

  task.appendChild(checkbox);
  task.appendChild(li);
  task.appendChild(editButton);
  task.appendChild(deleteButton);
  listContainer.appendChild(task);

  inputBox.value = '';
}

function toggleTaskCompletion() {
  const li = this.nextElementSibling;
  if (!editMode) {
    li.style.textDecoration = this.checked ? "line-through" : "none";
  } else {
    this.checked = false;
  }
}

function enableEditMode(li) {
  li.contentEditable = true;
  li.classList.add("editable");
  placeCursorAtEnd(li);
}

function placeCursorAtEnd(element) {
  const range = document.createRange();
  const selection = window.getSelection();
  range.selectNodeContents(element);
  range.collapse(false);
  selection.removeAllRanges();
  selection.addRange(range);
  element.focus();
}

function disableEditMode(li) {
  li.contentEditable = false;
  li.classList.remove("editable");
}

document.addEventListener("keydown", function(event) {
  if (event.keyCode === 13 && editMode) {
    event.preventDefault();
    const editableTask = document.querySelector(".task .editable");
    if (editableTask) {
      disableEditMode(editableTask);
      editMode = false;
    }
  }
});

// Utility function to escape HTML characters
function escapeHTML(text) {
  const element = document.createElement('div');
  element.textContent = text;
  return element.innerHTML;
}
