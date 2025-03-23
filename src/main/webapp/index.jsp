<!DOCTYPE html>
<html lang="en">
<head>
    <title>Construction Xpert - Home</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <script src="https://cdn.tailwindcss.com"></script>
    <style>
        /* Custom background image styling with overlay */
        .hero-bg {
            background-image: url('/construction-xpert/images/construction-hero.jpg');
            background-size: cover;
            background-position: center;
            background-repeat: no-repeat;
            position: relative;
        }

        .hero-bg::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background-color: rgba(16, 64, 43, 0.7); /* Dark green overlay */
            z-index: 1;
        }

        .hero-content {
            position: relative;
            z-index: 2;
        }
    </style>
</head>
<body class="font-sans bg-gray-50">
<!-- Header and Navigation -->
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
            <li><a href="#" class="hover:text-green-300 font-medium">HOME</a></li>
            <li><a href="#" class="hover:text-green-300 font-medium">PROJECTS</a></li>
            <li><a href="#" class="hover:text-green-300 font-medium">TASKS</a></li>
            <li><a href="#" class="hover:text-green-300 font-medium">RESOURCES</a></li>
            <li><a href="#" class="hover:text-green-300 font-medium">CONTACT</a></li>
        </ul>
        <button class="md:hidden">
            <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 6h16M4 12h16M4 18h16" />
            </svg>
        </button>
    </div>
</nav>

<!-- Hero Section with Image -->
<header class="hero-bg relative py-32">
    <div class="hero-content container mx-auto px-6">
        <div class="max-w-xl text-white">
            <h1 class="text-5xl font-bold mb-2">Construction.</h1>
            <h1 class="text-5xl font-bold mb-6">Redefined.</h1>
            <p class="text-xl mb-8">Plan it. Track it. Build it. All in one powerful platform designed for builders like you.</p>
            <a href="#features" class="inline-block bg-green-500 hover:bg-green-600 text-white font-semibold py-3 px-8 rounded-lg shadow-lg transition duration-300">
                DISCOVER MORE
            </a>
        </div>
    </div>
</header>

<!-- Features Section -->
<section id="features" class="container mx-auto px-6 py-20">
    <div class="text-center mb-16">
        <h2 class="text-4xl font-bold text-gray-800 mb-4">Master Your Construction Projects</h2>
        <q class="text-lg text-gray-600 max-w-3xl mx-auto">
            Take control of every detail in your projects.
        </q>
    </div>

    <div class="grid grid-cols-1 md:grid-cols-3 gap-8 mb-16">
        <!-- Projects Card -->
        <div class="bg-white p-8 rounded-lg shadow-xl border-t-4 border-green-600 hover:shadow-2xl transition duration-300">
            <h3 class="text-2xl font-semibold text-gray-800 mb-3">Projects</h3>
            <p class="text-gray-600 mb-4">Launch and manage your construction projects with precision and confidence.</p>
            <a href="projet" class="text-green-600 hover:text-green-800 font-medium flex items-center">
                Go to Projects
                <svg xmlns="http://www.w3.org/2000/svg" class="h-4 w-4 ml-1" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M14 5l7 7m0 0l-7 7m7-7H3" />
                </svg>
            </a>
        </div>

        <!-- Tasks Card -->
        <div class="bg-white p-8 rounded-lg shadow-xl border-t-4 border-green-600 hover:shadow-2xl transition duration-300">
            <h3 class="text-2xl font-semibold text-gray-800 mb-3">Tasks</h3>
            <p class="text-gray-600 mb-4">Stay on top of every task, from planning to completion, with our intuitive tracking system.</p>
            <a href="tache?projetId=1" class="text-green-600 hover:text-green-800 font-medium flex items-center">
                View Tasks
                <svg xmlns="http://www.w3.org/2000/svg" class="h-4 w-4 ml-1" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M14 5l7 7m0 0l-7 7m7-7H3" />
                </svg>
            </a>
        </div>

        <!-- Resources Card -->
        <div class="bg-white p-8 rounded-lg shadow-xl border-t-4 border-green-600 hover:shadow-2xl transition duration-300">
            <h3 class="text-2xl font-semibold text-gray-800 mb-3">Resources</h3>
            <p class="text-gray-600 mb-4">Track materials, equipment, and suppliers effortlessly to optimize your resource allocation.</p>
            <a href="ressource" class="text-green-600 hover:text-green-800 font-medium flex items-center">
                Manage Resources
                <svg xmlns="http://www.w3.org/2000/svg" class="h-4 w-4 ml-1" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M14 5l7 7m0 0l-7 7m7-7H3" />
                </svg>
            </a>
        </div>
    </div>
</section>

<!-- Call to Action -->
<section class="bg-green-100 py-16">
    <div class="container mx-auto px-6 text-center">
        <h2 class="text-3xl font-bold text-gray-800 mb-4">Ready to Build Smarter?</h2>
        <p class="text-lg text-gray-600 mb-8 max-w-2xl mx-auto">Join Construction Xpert today and transform the way you manage construction projects.</p>
        <a href="projet" class="inline-block bg-green-600 hover:bg-green-800 text-white font-semibold py-3 px-10 rounded-lg shadow-lg transition duration-300">
            GET STARTED NOW
        </a>
    </div>
</section>

<!-- Footer -->
<footer class="bg-green-800 text-white py-8">
    <div class="container mx-auto px-6">
        <div class="flex flex-col md:flex-row justify-between items-center">
            <div class="flex items-center mb-4 md:mb-0">
                <div class="w-8 h-8 bg-white rounded-md flex items-center justify-center mr-2">
                    <div class="w-5 h-5 border-2 border-green-800"></div>
                </div>
                <span class="font-bold">CONSTRUCTION XPERT</span>
            </div>
            <div class="text-sm">
                © 2025 Construction Xpert. All rights reserved.
            </div>
        </div>
    </div>
</footer>
</body>
</html>