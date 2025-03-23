<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Construction Xpert - New Project</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="font-sans bg-gray-50">
<!-- Navbar -->
<nav class="bg-green-800 text-white">
    <div class="container mx-auto px-6 py-4 flex justify-between items-center">
        <div class="flex items-center">
            <div class="w-10 h-10 bg-white rounded-md flex items-center justify-center mr-2">
                <div class="w-6 h-6 border-2 border-green-800"></div>
            </div>
            <div>
                <div class="text-sm font-bold">CONSTRUCTION</div>
                <div class="text-sm font-bold">XPERT</div>
            </div>
        </div>
        <ul class="hidden md:flex space-x-6">
            <li><a href="index.jsp" class="hover:text-green-300 font-medium">HOME</a></li>
            <li><a href="projet" class="hover:text-green-300 font-medium">PROJECTS</a></li>
            <li><a href="tache" class="hover:text-green-300 font-medium">TASKS</a></li>
            <li><a href="resources.jsp" class="hover:text-green-300 font-medium">RESOURCES</a></li>
        </ul>
    </div>
</nav>

<!-- Form Section -->
<section class="container mx-auto px-6 py-20">
    <div class="max-w-lg mx-auto bg-white p-8 rounded-lg shadow-xl border-t-4 border-green-600">
        <h2 class="text-2xl font-bold text-green-800 mb-6">Add New Project</h2>
        <form id="projectForm" action="projet" method="post" onsubmit="return validateForm()">
            <input type="hidden" name="action" value="add">
            <div class="mb-4">
                <label for="nom" class="block text-gray-700 font-medium mb-2">Name</label>
                <input type="text" id="nom" name="nom" class="w-full p-3 border border-green-600 rounded-lg">
                <span id="nomError" class="text-red-500 text-sm hidden">Name is required and must contain only letters and spaces</span>
            </div>
            <div class="mb-4">
                <label for="description" class="block text-gray-700 font-medium mb-2">Description</label>
                <textarea id="description" name="description" rows="4" class="w-full p-3 border border-green-600 rounded-lg"></textarea>
                <span id="descriptionError" class="text-red-500 text-sm hidden">Description is required</span>
            </div>
            <div class="mb-4">
                <label for="dateDebut" class="block text-gray-700 font-medium mb-2">Start Date</label>
                <input type="date" id="dateDebut" name="dateDebut" class="w-full p-3 border border-green-600 rounded-lg">
                <span id="dateDebutError" class="text-red-500 text-sm hidden">Start date is required and must be before end date</span>
            </div>
            <div class="mb-4">
                <label for="dateFin" class="block text-gray-700 font-medium mb-2">End Date</label>
                <input type="date" id="dateFin" name="dateFin" class="w-full p-3 border border-green-600 rounded-lg">
                <span id="dateFinError" class="text-red-500 text-sm hidden">End date is required and must be after start date</span>
            </div>
            <div class="mb-6">
                <label for="budget" class="block text-gray-700 font-medium mb-2">Budget</label>
                <input type="number" id="budget" name="budget" step="0.01" class="w-full p-3 border border-green-600 rounded-lg">
                <span id="budgetError" class="text-red-500 text-sm hidden">Budget is required and must be positive</span>
            </div>
            <div class="flex justify-end space-x-4">
                <a href="projet" class="px-6 py-2 border border-gray-300 rounded-lg text-gray-700 hover:bg-gray-100">Cancel</a>
                <a href="projet" class="px-6 py-2 bg-blue-600 text-white rounded-lg hover:bg-blue-700 shadow-md">Project List</a>
                <button type="submit" class="px-6 py-2 bg-green-600 text-white rounded-lg hover:bg-green-700 shadow-md">Create Project</button>
            </div>
        </form>
    </div>
</section>

<!-- Footer -->
<footer class="bg-green-800 text-white py-8">
    <div class="container mx-auto px-6 text-center">
        <div class="flex items-center justify-center mb-4">
            <div class="w-8 h-8 bg-white rounded-md flex items-center justify-center mr-2">
                <div class="w-5 h-5 border-2 border-green-800"></div>
            </div>
            <span class="font-bold">CONSTRUCTION XPERT</span>
        </div>
        <div class="text-sm">© 2025 Construction Xpert. All rights reserved.</div>
    </div>
</footer>

<!-- Validation Script -->
<script>
    // Set default start date to today
    document.addEventListener('DOMContentLoaded', () => {
        const today = new Date().toISOString().split('T')[0];
        document.getElementById('dateDebut').value = today;
    });

    function validateForm() {
        document.querySelectorAll('#projectForm .text-red-500').forEach(error => error.classList.add('hidden'));
        let isValid = true;

        const nom = document.getElementById('nom').value.trim();
        const description = document.getElementById('description').value.trim();
        const dateDebut = document.getElementById('dateDebut').value;
        const dateFin = document.getElementById('dateFin').value;
        const budget = parseFloat(document.getElementById('budget').value);

        const nomRegex = /^[a-zA-Z\s]+$/;
        if (!nom || !nomRegex.test(nom)) {
            document.getElementById('nomError').classList.remove('hidden');
            isValid = false;
        }
        if (!description) {
            document.getElementById('descriptionError').classList.remove('hidden');
            isValid = false;
        }
        if (!dateDebut) {
            document.getElementById('dateDebutError').classList.remove('hidden');
            isValid = false;
        }
        if (!dateFin) {
            document.getElementById('dateFinError').classList.remove('hidden');
            isValid = false;
        }
        if (dateDebut && dateFin && new Date(dateDebut) >= new Date(dateFin)) {
            document.getElementById('dateDebutError').classList.remove('hidden');
            document.getElementById('dateFinError').classList.remove('hidden');
            isValid = false;
        }
        if (isNaN(budget) || budget <= 0) {
            document.getElementById('budgetError').classList.remove('hidden');
            isValid = false;
        }

        return isValid;
    }
</script>
</body>
</html>