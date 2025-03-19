<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
  <title>Task List</title>
  <meta charset="UTF-8">
  <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-100 font-sans">
<div class="container mx-auto p-6">
  <h1 class="text-3xl font-bold mb-6 text-gray-800">Task List for Project ID: ${projetId}</h1>

  <!-- Debug Output -->
  <p class="text-gray-600 mb-4">Debug: projetId = ${projetId}</p>

  <table class="w-full bg-white shadow-md rounded-lg overflow-hidden">
    <thead class="bg-gray-200">
    <tr>
      <th class="p-3 text-left">ID</th>
      <th class="p-3 text-left">Description</th>
      <th class="p-3 text-left">Start Date</th>
      <th class="p-3 text-left">End Date</th>
      <th class="p-3 text-left">Actions</th>
    </tr>
    </thead>
    <tbody>
    <c:forEach var="tache" items="${taches}">
      <tr class="border-b">
        <td class="p-3">${tache.id}</td>
        <td class="p-3">${tache.description}</td>
        <td class="p-3">${tache.dateDebut}</td>
        <td class="p-3">${tache.dateFin}</td>
        <td class="p-3 space-x-2">
          <a href="tache?action=edit&id=${tache.id}&projetId=${projetId}" class="text-green-500 hover:underline">Edit</a>
          <a href="tache?action=delete&id=${tache.id}&projetId=${projetId}" class="text-red-500 hover:underline" onclick="return confirm('Are you sure you want to delete this task?');">Delete</a>
        </td>
      </tr>
    </c:forEach>
    </tbody>
  </table>

  <!-- Add New Task Form -->
  <h2 class="text-2xl font-semibold mt-8 mb-4 text-gray-700">Add New Task</h2>
  <form action="tache" method="post" class="bg-white p-6 rounded-lg shadow-md" id="taskForm" onsubmit="return validateAddForm()">
    <input type="hidden" name="action" value="add">
    <div class="mb-4">
      <label for="project_id" class="block text-gray-700">Project:</label>
      <select id="project_id" name="project_id" class="w-full p-2 border rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500">
        <option value="">Select a project</option>
        <c:forEach var="projet" items="${projets}">
          <option value="${projet.id}" ${projet.id == projetId ? 'selected' : ''}>${projet.nom}</option>
        </c:forEach>
      </select>
      <span id="addProjectError" class="text-red-500 text-sm hidden">Please select a valid project</span>
    </div>
    <div class="mb-4">
      <label class="block text-gray-700">Description:</label>
      <input type="text" name="description" id="addDescription" class="w-full p-2 border rounded-md">
      <span id="addDescriptionError" class="text-red-500 text-sm hidden">Description is required</span>
    </div>
    <div class="mb-4">
      <label class="block text-gray-700">Start Date:</label>
      <input type="date" name="dateDebut" id="addDateDebut" class="w-full p-2 border rounded-md">
      <span id="addDateDebutError" class="text-red-500 text-sm hidden">Start date is required and must be before end date</span>
    </div>
    <div class="mb-4">
      <label class="block text-gray-700">End Date:</label>
      <input type="date" name="dateFin" id="addDateFin" class="w-full p-2 border rounded-md">
      <span id="addDateFinError" class="text-red-500 text-sm hidden">End date is required and must be after start date</span>
    </div>
    <button type="submit" class="bg-blue-500 text-white p-2 rounded-md hover:bg-blue-600">Add Task</button>
  </form>

  <!-- Edit Task Form (shown only if editing) -->
  <c:if test="${not empty tacheToEdit}">
    <h2 class="text-2xl font-semibold mt-8 mb-4 text-gray-700">Edit Task</h2>
    <form action="tache" method="post" class="bg-white p-6 rounded-lg shadow-md" id="editTaskForm" onsubmit="return validateEditForm()">
      <input type="hidden" name="action" value="update">
      <input type="hidden" name="id" value="${tacheToEdit.id}">
      <div class="mb-4">
        <label for="edit_project_id" class="block text-gray-700">Project:</label>
        <select id="edit_project_id" name="project_id" class="w-full p-2 border rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500">
          <option value="">Select a project</option>
          <c:forEach var="projet" items="${projets}">
            <option value="${projet.id}" ${projet.id == tacheToEdit.projetId ? 'selected' : ''}>${projet.nom}</option>
          </c:forEach>
        </select>
        <span id="editProjectError" class="text-red-500 text-sm hidden">Please select a valid project</span>
      </div>
      <div class="mb-4">
        <label class="block text-gray-700">Description:</label>
        <input type="text" name="description" id="editDescription" value="${tacheToEdit.description}" class="w-full p-2 border rounded-md">
        <span id="editDescriptionError" class="text-red-500 text-sm hidden">Description is required</span>
      </div>
      <div class="mb-4">
        <label class="block text-gray-700">Start Date:</label>
        <input type="date" name="dateDebut" id="editDateDebut" value="${tacheToEdit.dateDebut}" class="w-full p-2 border rounded-md">
        <span id="editDateDebutError" class="text-red-500 text-sm hidden">Start date is required and must be before end date</span>
      </div>
      <div class="mb-4">
        <label class="block text-gray-700">End Date:</label>
        <input type="date" name="dateFin" id="editDateFin" value="${tacheToEdit.dateFin}" class="w-full p-2 border rounded-md">
        <span id="editDateFinError" class="text-red-500 text-sm hidden">End date is required and must be after start date</span>
      </div>
      <button type="submit" class="bg-green-500 text-white p-2 rounded-md hover:bg-green-600">Update Task</button>
    </form>
  </c:if>

  <a href="projet" class="mt-4 inline-block text-blue-500 hover:underline">Back to Project List</a>
</div>

<script>
  // Validation for Add Form
  function validateAddForm() {
    // Reset error messages
    document.querySelectorAll('#taskForm .text-red-500').forEach(error => error.classList.add('hidden'));

    let isValid = true;

    // Get field values
    const projectId = document.getElementById('project_id').value;
    const description = document.getElementById('addDescription').value.trim();
    const dateDebut = document.getElementById('addDateDebut').value;
    const dateFin = document.getElementById('addDateFin').value;

    // Validate Project ID
    if (!projectId || isNaN(parseInt(projectId))) {
      document.getElementById('addProjectError').classList.remove('hidden');
      isValid = false;
    }

    // Validate Description
    if (!description) {
      document.getElementById('addDescriptionError').classList.remove('hidden');
      isValid = false;
    }

    // Validate Dates
    if (!dateDebut) {
      document.getElementById('addDateDebutError').classList.remove('hidden');
      isValid = false;
    }
    if (!dateFin) {
      document.getElementById('addDateFinError').classList.remove('hidden');
      isValid = false;
    }
    if (dateDebut && dateFin) {
      const debut = new Date(dateDebut);
      const fin = new Date(dateFin);
      if (debut > fin) {
        document.getElementById('addDateDebutError').classList.remove('hidden');
        document.getElementById('addDateFinError').classList.remove('hidden');
        isValid = false;
      }
    }

    return isValid;
  }

  // Validation for Edit Form
  function validateEditForm() {
    // Reset error messages
    document.querySelectorAll('#editTaskForm .text-red-500').forEach(error => error.classList.add('hidden'));

    let isValid = true;

    // Get field values
    const projectId = document.getElementById('edit_project_id').value;
    const description = document.getElementById('editDescription').value.trim();
    const dateDebut = document.getElementById('editDateDebut').value;
    const dateFin = document.getElementById('editDateFin').value;

    // Validate Project ID
    if (!projectId || isNaN(parseInt(projectId))) {
      document.getElementById('editProjectError').classList.remove('hidden');
      isValid = false;
    }

    // Validate Description
    if (!description) {
      document.getElementById('editDescriptionError').classList.remove('hidden');
      isValid = false;
    }

    // Validate Dates
    if (!dateDebut) {
      document.getElementById('editDateDebutError').classList.remove('hidden');
      isValid = false;
    }
    if (!dateFin) {
      document.getElementById('editDateFinError').classList.remove('hidden');
      isValid = false;
    }
    if (dateDebut && dateFin) {
      const debut = new Date(dateDebut);
      const fin = new Date(dateFin);
      if (debut > fin) {
        document.getElementById('editDateDebutError').classList.remove('hidden');
        document.getElementById('editDateFinError').classList.remove('hidden');
        isValid = false;
      }
    }

    return isValid;
  }

  // Event Listeners
  document.addEventListener('DOMContentLoaded', function() {
    const addForm = document.getElementById('taskForm');
    console.log('Add form preselected project_id:', document.getElementById('project_id').value);

    addForm.addEventListener('submit', function(e) {
      if (!validateAddForm()) {
        e.preventDefault();
      }
    });

    const editForm = document.getElementById('editTaskForm');
    if (editForm) {
      console.log('Edit form preselected project_id:', document.getElementById('edit_project_id').value);
      editForm.addEventListener('submit', function(e) {
        if (!validateEditForm()) {
          e.preventDefault();
        }
      });
    }
  });
</script>
</body>
</html>