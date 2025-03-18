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
    </tr>
    </thead>
    <tbody>
    <c:forEach var="tache" items="${taches}">
      <tr class="border-b">
        <td class="p-3">${tache.id}</td>
        <td class="p-3">${tache.description}</td>
        <td class="p-3">${tache.dateDebut}</td>
        <td class="p-3">${tache.dateFin}</td>
      </tr>
    </c:forEach>
    </tbody>
  </table>

  <h2 class="text-2xl font-semibold mt-8 mb-4 text-gray-700">Add New Task</h2>
  <form action="tache" method="post" class="bg-white p-6 rounded-lg shadow-md" id="taskForm">
    <div class="mb-4">
      <label for="project_id" class="block text-gray-700">Project:</label>
      <select id="project_id" name="project_id" class="w-full p-2 border rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500" required>
        <option value="">Select a project</option>
        <c:forEach var="projet" items="${projets}">
          <option value="${projet.id}" ${projet.id == projetId ? 'selected' : ''}>${projet.nom}</option>
        </c:forEach>
      </select>
    </div>
    <div class="mb-4">
      <label class="block text-gray-700">Description:</label>
      <input type="text" name="description" class="w-full p-2 border rounded-md" required>
    </div>
    <div class="mb-4">
      <label class="block text-gray-700">Start Date:</label>
      <input type="date" name="dateDebut" class="w-full p-2 border rounded-md" required>
    </div>
    <div class="mb-4">
      <label class="block text-gray-700">End Date:</label>
      <input type="date" name="dateFin" class="w-full p-2 border rounded-md" required>
    </div>
    <button type="submit" class="bg-blue-500 text-white p-2 rounded-md hover:bg-blue-600">Add Task</button>
  </form>

  <a href="projet" class="mt-4 inline-block text-blue-500 hover:underline">Back to Project List</a>
</div>

<script>
  document.addEventListener('DOMContentLoaded', function() {
    const form = document.getElementById('taskForm');
    const projectSelect = document.getElementById('project_id');

    console.log('Current preselected project_id:', projectSelect.value);

    form.addEventListener('submit', function(e) {
      const projectId = projectSelect.value;
      console.log('Submitting form with project_id:', projectId);

      if (!projectId || isNaN(parseInt(projectId))) {
        console.error('Invalid project_id:', projectId);
        e.preventDefault();
        alert('Please select a valid project.');
      }
    });
  });
</script>
</body>
</html>