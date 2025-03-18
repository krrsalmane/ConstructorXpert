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
        <td class="p-3">
          <a href="tache?projetId=${projet.id}" class="text-blue-500 hover:underline">View Tasks</a>
        </td>
      </tr>
    </c:forEach>
    </tbody>
  </table>
  <h2 class="text-2xl font-semibold mt-8 mb-4 text-gray-700">Add New Project</h2>
  <form action="projet" method="post" class="bg-white p-6 rounded-lg shadow-md">
    <div class="mb-4">
      <label class="block text-gray-700">Name:</label>
      <input type="text" name="nom" class="w-full p-2 border rounded-md" required>
    </div>
    <div class="mb-4">
      <label class="block text-gray-700">Description:</label>
      <input type="text" name="description" class="w-full p-2 border rounded-md">
    </div>
    <div class="mb-4">
      <label class="block text-gray-700">Start Date:</label>
      <input type="date" name="dateDebut" class="w-full p-2 border rounded-md" required>
    </div>
    <div class="mb-4">
      <label class="block text-gray-700">End Date:</label>
      <input type="date" name="dateFin" class="w-full p-2 border rounded-md" required>
    </div>
    <div class="mb-4">
      <label class="block text-gray-700">Budget:</label>
      <input type="number" name="budget" step="0.01" class="w-full p-2 border rounded-md" required>
    </div>
    <button type="submit" class="bg-blue-500 text-white p-2 rounded-md hover:bg-blue-600">Add Project</button>
  </form>
</div>
</body>
</html>