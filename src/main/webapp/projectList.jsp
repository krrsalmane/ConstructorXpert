<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
  <title>Project List</title>
  <meta charset="UTF-8">
  <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-100 font-sans">
<div class="container mx-auto p-6">
  <h1 class="text-3xl font-bold mb-6 text-gray-800">Projects</h1>
  <table class="w-full bg-white shadow-md rounded-lg overflow-hidden">
    <thead class="bg-gray-200">
    <tr>
      <th class="p-3 text-left">ID</th>
      <th class="p-3 text-left">Name</th>
      <th class="p-3 text-left">Description</th>
      <th class="p-3 text-left">Start Date</th>
      <th class="p-3 text-left">End Date</th>
      <th class="p-3 text-left">Budget</th>
      <th class="p-3 text-left">Actions</th>
    </tr>
    </thead>
    <tbody>
    <c:forEach var="projet" items="${projets}">
      <tr class="border-b">
        <td class="p-3">${projet.id}</td>
        <td class="p-3">${projet.nom}</td>
        <td class="p-3">${projet.description}</td>
        <td class="p-3">${projet.dateDebut}</td>
        <td class="p-3">${projet.dateFin}</td>
        <td class="p-3">${projet.budget}</td>
        <td class="p-3 space-x-2">
          <a href="tache?projetId=${projet.id}" class="text-blue-500 hover:underline">View Tasks</a>
          <a href="projet?action=edit&id=${projet.id}" class="text-green-500 hover:underline">Edit</a>
          <a href="projet?action=delete&id=${projet.id}" class="text-red-500 hover:underline" onclick="return confirm('Are you sure you want to delete this project?');">Delete</a>
        </td>
      </tr>
    </c:forEach>
    </tbody>
  </table>

  <!-- Add New Project Form -->
  <h2 class="text-2xl font-semibold mt-8 mb-4 text-gray-700">Add New Project</h2>
  <form action="projet" method="post" class="bg-white p-6 rounded-lg shadow-md" id="addProjectForm" onsubmit="return validateAddForm()">
    <input type="hidden" name="action" value="add">
    <div class="mb-4">
      <label class="block text-gray-700">Name:</label>
      <input type="text" name="nom" id="addNom" class="w-full p-2 border rounded-md">
      <span id="addNomError" class="text-red-500 text-sm hidden">Name is required and must contain only letters and spaces</span>
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
    <div class="mb-4">
      <label class="block text-gray-700">Budget:</label>
      <input type="number" name="budget" id="addBudget" step="0.01" class="w-full p-2 border rounded-md">
      <span id="addBudgetError" class="text-red-500 text-sm hidden">Budget is required and must be positive</span>
    </div>
    <button type="submit" class="bg-blue-500 text-white p-2 rounded-md hover:bg-blue-600">Add Project</button>
  </form>

  <!-- Edit Project Form (shown only if editing) -->
  <c:if test="${not empty projetToEdit}">
    <h2 class="text-2xl font-semibold mt-8 mb-4 text-gray-700">Edit Project</h2>
    <form action="projet" method="post" class="bg-white p-6 rounded-lg shadow-md" id="editProjectForm" onsubmit="return validateEditForm()">
      <input type="hidden" name="action" value="update">
      <input type="hidden" name="id" value="${projetToEdit.id}">
      <div class="mb-4">
        <label class="block text-gray-700">Name:</label>
        <input type="text" name="nom" id="editNom" value="${projetToEdit.nom}" class="w-full p-2 border rounded-md">
        <span id="editNomError" class="text-red-500 text-sm hidden">Name is required and must contain only letters and spaces</span>
      </div>
      <div class="mb-4">
        <label class="block text-gray-700">Description:</label>
        <input type="text" name="description" id="editDescription" value="${projetToEdit.description}" class="w-full p-2 border rounded-md">
        <span id="editDescriptionError" class="text-red-500 text-sm hidden">Description is required</span>
      </div>
      <div class="mb-4">
        <label class="block text-gray-700">Start Date:</label>
        <input type="date" name="dateDebut" id="editDateDebut" value="${projetToEdit.dateDebut}" class="w-full p-2 border rounded-md">
        <span id="editDateDebutError" class="text-red-500 text-sm hidden">Start date is required and must be before end date</span>
      </div>
      <div class="mb-4">
        <label class="block text-gray-700">End Date:</label>
        <input type="date" name="dateFin" id="editDateFin" value="${projetToEdit.dateFin}" class="w-full p-2 border rounded-md">
        <span id="editDateFinError" class="text-red-500 text-sm hidden">End date is required and must be after start date</span>
      </div>
      <div class="mb-4">
        <label class="block text-gray-700">Budget:</label>
        <input type="number" name="budget" id="editBudget" step="0.01" value="${projetToEdit.budget}" class="w-full p-2 border rounded-md">
        <span id="editBudgetError" class="text-red-500 text-sm hidden">Budget is required and must be positive</span>
      </div>
      <button type="submit" class="bg-green-500 text-white p-2 rounded-md hover:bg-green-600">Update Project</button>
    </form>
  </c:if>
</div>

<script>
  // Validation for Add Form
  function validateAddForm() {
    // Reset error messages
    document.querySelectorAll('#addProjectForm .text-red-500').forEach(error => error.classList.add('hidden'));
    let isValid = true;
    // Get field values
    const nom = document.getElementById('addNom').value.trim();
    const description = document.getElementById('addDescription').value.trim();
    const dateDebut = document.getElementById('addDateDebut').value;
    const dateFin = document.getElementById('addDateFin').value;
    const budget = parseFloat(document.getElementById('addBudget').value);

    // Validate Name (required, letters and spaces only)
    const nomRegex = /^[a-zA-Z\s]+$/;
    if (!nom || !nomRegex.test(nom)) {
      document.getElementById('addNomError').classList.remove('hidden');
      isValid = false;
    }

    // Validate Description (required)
    if (!description) {
      document.getElementById('addDescriptionError').classList.remove('hidden');
      isValid = false;
    }

    // Validate Dates (required and logical order)
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

    // Validate Budget (required and positive)
    if (isNaN(budget) || budget <= 0) {
      document.getElementById('addBudgetError').classList.remove('hidden');
      isValid = false;
    }

    return isValid;
  }

  // Validation for Edit Form
  function validateEditForm() {
    // Reset error messages
    document.querySelectorAll('#editProjectForm .text-red-500').forEach(error => error.classList.add('hidden'));

    let isValid = true;

    // Get field values
    const nom = document.getElementById('editNom').value.trim();
    const description = document.getElementById('editDescription').value.trim();
    const dateDebut = document.getElementById('editDateDebut').value;
    const dateFin = document.getElementById('editDateFin').value;
    const budget = parseFloat(document.getElementById('editBudget').value);

    // Validate Name (required, letters and spaces only)
    const nomRegex = /^[a-zA-Z\s]+$/;
    if (!nom || !nomRegex.test(nom)) {
      document.getElementById('editNomError').classList.remove('hidden');
      isValid = false;
    }

    // Validate Description (required)
    if (!description) {
      document.getElementById('editDescriptionError').classList.remove('hidden');
      isValid = false;
    }

    // Validate Dates (required and logical order)
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
    // Validate Budget (required and positive)
    if (isNaN(budget) || budget <= 0) {
      document.getElementById('editBudgetError').classList.remove('hidden');
      isValid = false;
    }

    return isValid;
  }
</script>
</body>
</html>