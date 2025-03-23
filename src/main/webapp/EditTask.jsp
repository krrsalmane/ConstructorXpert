<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Construction Xpert - Edit Task</title>
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
    <c:choose>
        <c:when test="${not empty tacheToEdit}">
            <div class="max-w-lg mx-auto bg-white p-8 rounded-lg shadow-xl border-t-4 border-green-600">
                <h2 class="text-2xl font-bold text-green-800 mb-6">Edit Task</h2>
                <form id="taskForm" action="tache" method="post" onsubmit="return validateForm()">
                    <input type="hidden" name="action" value="update">
                    <input type="hidden" name="id" value="${tacheToEdit.id}">
                    <input type="hidden" name="project_id" value="${tacheToEdit.projetId}">
                    <div class="mb-4">
                        <label for="description" class="block text-gray-700 font-medium mb-2">Description</label>
                        <textarea id="description" name="description" rows="4" class="w-full p-3 border border-green-600 rounded-lg" required>${tacheToEdit.description}</textarea>
                        <span id="descriptionError" class="text-red-500 text-sm hidden">Description is required</span>
                    </div>
                    <div class="mb-4">
                        <label for="dateDebut" class="block text-gray-700 font-medium mb-2">Start Date</label>
                        <input type="date" id="dateDebut" name="dateDebut" value="${tacheToEdit.dateDebut.toString()}" class="w-full p-3 border border-green-600 rounded-lg" required>
                        <span id="dateDebutError" class="text-red-500 text-sm hidden">Start date is required and must be before end date</span>
                    </div>
                    <div class="mb-4">
                        <label for="dateFin" class="block text-gray-700 font-medium mb-2">End Date</label>
                        <input type="date" id="dateFin" name="dateFin" value="${tacheToEdit.dateFin.toString()}" class="w-full p-3 border border-green-600 rounded-lg" required>
                        <span id="dateFinError" class="text-red-500 text-sm hidden">End date is required and must be after start date</span>
                    </div>
                    <div class="flex justify-end space-x-4">
                        <a href="tache?projetId=${tacheToEdit.projetId}" class="px-6 py-2 border border-gray-300 rounded-lg text-gray-700 hover:bg-gray-100">Cancel</a>
                        <button type="submit" class="px-6 py-2 bg-green-600 text-white rounded-lg hover:bg-green-700 shadow-md">Update Task</button>
                    </div>
                </form>
            </div>
        </c:when>
        <c:otherwise>
            <div class="max-w-lg mx-auto bg-white p-8 rounded-lg shadow-xl border-t-4 border-red-600 text-center">
                <h2 class="text-2xl font-bold text-red-800 mb-6">Error</h2>
                <p class="text-gray-700">Task not found. Please try again.</p>
                <a href="tache?projetId=${param.projetId}" class="mt-4 inline-block px-6 py-2 bg-green-600 text-white rounded-lg hover:bg-green-700">Back to Tasks</a>
            </div>
        </c:otherwise>
    </c:choose>
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
    function validateForm() {
        document.querySelectorAll('#taskForm .text-red-500').forEach(error => error.classList.add('hidden'));
        let isValid = true;

        const description = document.getElementById('description').value.trim();
        const dateDebut = document.getElementById('dateDebut').value;
        const dateFin = document.getElementById('dateFin').value;

        if (!description) {
            document.getElementById('descriptionError').classList.remove('hidden');
            isValid = false;
        }
        if (!dateDebut || !dateFin || new Date(dateDebut) > new Date(dateFin)) {
            document.getElementById('dateDebutError').classList.remove('hidden');
            document.getElementById('dateFinError').classList.remove('hidden');
            isValid = false;
        }

        return isValid;
    }
</script>
</body>
</html>