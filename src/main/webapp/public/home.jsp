<%@ page contentType="text/html;charset=UTF-8" isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
    var ctx = request.getContextPath();
    var connectedUser = (ma.bankati.model.users.User) session.getAttribute("connectedUser");
%>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Accueil | Bankati</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <style>
        :root {
            --main-bg1: #43cea2;
            --main-bg2: #185a9d;
            --brand-gradient: linear-gradient(135deg, var(--main-bg2), var(--main-bg1));
            --brand-gradient-reverse: linear-gradient(135deg, var(--main-bg1), var(--main-bg2));
            --brand-shadow: 67,206,162;
            --accent-color: #ffd600;
        }
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body {
            font-family: 'Inter', sans-serif;
            background: var(--brand-gradient),
            url('data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 1000 1000"><defs><linearGradient id="bg" x1="0%" y1="0%" x2="100%" y2="100%"><stop offset="0%" style="stop-color:%2343cea2;stop-opacity:1" /><stop offset="100%" style="stop-color:%23185a9d;stop-opacity:1" /></linearGradient></defs><rect width="1000" height="1000" fill="url(%23bg)"/><g opacity="0.08"><circle cx="200" cy="200" r="100" fill="white"/><circle cx="800" cy="300" r="150" fill="white"/><circle cx="400" cy="700" r="80" fill="white"/><circle cx="700" cy="800" r="120" fill="white"/><rect x="100" y="500" width="200" height="100" rx="10" fill="white"/><rect x="600" y="100" width="250" height="120" rx="15" fill="white"/></g></svg>');
            background-size: cover;
            background-attachment: fixed;
            min-height: 100vh;
            color: #fff;
        }
        body::before {
            content: '';
            position: fixed; top: 0; left: 0; right: 0; bottom: 0;
            background-image:
                    radial-gradient(circle at 20% 20%, rgba(255,255,255,0.06) 1px, transparent 1px),
                    radial-gradient(circle at 80% 30%, rgba(255,255,255,0.04) 1px, transparent 1px),
                    radial-gradient(circle at 40% 70%, rgba(255,255,255,0.04) 1px, transparent 1px),
                    radial-gradient(circle at 90% 80%, rgba(255,255,255,0.06) 1px, transparent 1px);
            background-size: 200px 200px,300px 300px,250px 250px,180px 180px;
            animation: float 20s infinite linear;
            pointer-events: none;
            z-index: 1;
        }
        @keyframes float {
            0%   { transform: translate(0,0);}
            25%  { transform: translate(5px,-10px);}
            50%  { transform: translate(-5px,-5px);}
            75%  { transform: translate(3px,-15px);}
            100% { transform: translate(0,0);}
        }
        .navbar {
            background: rgba(255,255,255,0.12) !important;
            backdrop-filter: blur(16px);
            border-bottom: 1px solid rgba(255,255,255,0.13);
        }
        .navbar-brand { font-weight: 700; font-size: 1.3rem; }
        .nav-link {
            color: #fff !important;
            font-weight: 500;
            border-radius: 10px;
            margin: 0 .2rem;
            transition: all 0.3s;
        }
        .nav-link:hover, .nav-link.active {
            background: rgba(255,255,255,0.19) !important;
            color: #fff !important;
            transform: translateY(-2px);
        }
        .dropdown-menu {
            background: rgba(255,255,255,0.97) !important;
            border-radius: 12px;
        }
        .dropdown-item:hover {
            background: rgba(67,206,162,0.15) !important;
            color: #43cea2 !important;
        }
        /* --- HEADER USER --- */
        .user-header {
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 1.2rem;
            flex-wrap: wrap;
            margin: 2.7rem 0 2.3rem 0;
        }
        .user-avatar {
            width: 63px; height: 63px;
            background: linear-gradient(135deg,#43cea2 50%,#185a9d 100%);
            border-radius: 16px;
            display: flex; align-items: center; justify-content: center;
            box-shadow: 0 8px 24px rgba(67,206,162,0.13);
            font-size: 2.1rem;
            color: #fff;
        }
        .user-header-info { text-align: left; }
        .welcome-title {
            font-size: 2.2rem;
            font-weight: 700;
            margin-bottom: .2rem;
            color: #fff;
            text-shadow: 0 2px 10px rgba(0,0,0,0.14);
        }
        .welcome-subtitle {
            color: rgba(255,255,255,0.89);
            font-size: 1.08rem;
        }
        /* --- Service cards --- */
        .service-card {
            background: rgba(255,255,255,0.10);
            border: 1px solid rgba(255,255,255,0.13);
            border-radius: 21px;
            padding: 2rem 1.1rem;
            text-align: center;
            transition: all 0.3s;
            color: #fff;
            display: block;
            height: 100%;
            position: relative;
            overflow: hidden;
            z-index: 2;
        }
        .service-card::before {
            content: '';
            position: absolute; top:0; left:-100%; width:100%; height:100%;
            background: linear-gradient(90deg, transparent, rgba(255,255,255,0.10), transparent);
            transition: left 0.5s;
        }
        .service-card:hover::before { left: 100%; }
        .service-card:hover {
            background: rgba(255,255,255,0.19);
            transform: translateY(-6px) scale(1.02);
            border-color: rgba(255,255,255,0.24);
            color: #fff;
            text-decoration: none;
            box-shadow: 0 14px 40px rgba(var(--brand-shadow),0.13);
        }
        .service-icon {
            font-size: 2.6rem;
            margin-bottom: 1rem;
            color: rgba(255,255,255,0.93);
            transition: all 0.3s;
        }
        .service-card:hover .service-icon {
            transform: scale(1.10) rotate(4deg);
            color: var(--accent-color);
        }
        .service-title { font-size: 1.14rem; font-weight: 600; margin-bottom: .4rem;}
        .service-description {
            color: rgba(255,255,255,0.73);
            font-size: .99rem;
            line-height: 1.52;
        }
        /* --- User stats --- */
        .user-stats {
            background: rgba(255,255,255,0.09);
            border: 1px solid rgba(255,255,255,0.13);
            border-radius: 18px;
            padding: 2rem 1rem;
            margin: 2.2rem 0 2.2rem 0;
            box-shadow: 0 6px 24px rgba(67,206,162,0.13);
        }
        .stat-item { text-align: center; padding: 1rem;}
        .stat-number { font-size: 2rem; font-weight: 700; color: #fff; }
        .stat-label {
            color: rgba(255,255,255,0.65);
            font-size: .99rem;
            font-weight: 500;
            letter-spacing: 0.5px;
            text-transform: uppercase;
        }
        /* --- Dashboard card --- */
        .dashboard-card {
            background: rgba(255,255,255,0.12);
            border: 1px solid rgba(255,255,255,0.13);
            border-radius: 19px;
            box-shadow: 0 10px 32px rgba(var(--brand-shadow),0.14);
            position: relative;
            transition: .25s;
            z-index: 10;
            animation: slideUp 0.7s cubic-bezier(.68,-0.55,.27,1.55);
            opacity: 0;
        }
        .dashboard-card:hover {
            background: rgba(67,206,162,0.13);
            border-color: rgba(255,255,255,0.18);
            box-shadow: 0 18px 50px rgba(var(--brand-shadow),0.19);
            transform: translateY(-7px) scale(1.014);
        }
        @keyframes slideUp {
            to   { opacity: 1; transform: translateY(0);}
            from { opacity: 0; transform: translateY(30px);}
        }
        .footer {
            background: rgba(255,255,255,0.06);
            border-top: 1px solid rgba(255,255,255,0.13);
            margin-top: 3.5rem;
            padding: 2rem 0 1.1rem 0;
            text-align: center;
            color: rgba(255,255,255,0.74);
        }
        @media (max-width: 800px) {
            .welcome-title { font-size: 1.35rem;}
            .user-header { flex-direction: column;}
            .dashboard-card { margin-bottom: 1.1rem;}
        }
        .main-container { position: relative; z-index: 10;}
        .loading-animation { opacity: 0; animation: slideUp 0.7s cubic-bezier(.68,-0.55,.27,1.55) forwards;}
    </style>
</head>
<body>
<!-- NAVBAR -->
<nav class="navbar navbar-expand-lg navbar-dark sticky-top shadow">
    <div class="container-fluid">
        <a class="navbar-brand d-flex align-items-center" href="<%= ctx %>/home">
            <img src="<%= ctx %>/assets/img/logoBlue.png" alt="Logo" width="40" height="40" class="me-2">
            <strong class="text-white">Bankati</strong>
        </a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                <li class="nav-item">
                    <a class="nav-link text-white fw-bold active" href="<%= ctx %>/home">
                        <i class="bi bi-house-fill me-1"></i> Accueil
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link text-white fw-bold" href="<%= ctx %>/credit">
                        <i class="bi bi-bank2 me-1"></i> Mes crédits
                    </a>
                </li>
            </ul>
            <div class="dropdown d-flex align-items-center">
                <a class="btn btn-outline-light dropdown-toggle"
                   href="#" role="button" id="dropdownUserMenu" data-bs-toggle="dropdown" aria-expanded="false">
                    <i class="bi bi-person-circle me-1"></i>
                    <%= connectedUser.getFirstName() + " " + connectedUser.getLastName() %>
                </a>
                <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="dropdownUserMenu">
                    <li><span class="dropdown-item-text fw-bold text-primary"><%= connectedUser.getRole() %></span></li>
                    <li><hr class="dropdown-divider"></li>
                    <li><a class="dropdown-item" href="#"><i class="bi bi-person me-1"></i> Mon profil</a></li>
                    <li><a class="dropdown-item" href="#"><i class="bi bi-gear me-1"></i> Paramètres</a></li>
                    <li><hr class="dropdown-divider"></li>
                    <li>
                        <a class="dropdown-item text-danger logout-btn fw-bold" href="<%= ctx %>/logout">
                            <i class="bi bi-box-arrow-right me-1"></i> Déconnexion
                        </a>
                    </li>
                </ul>
            </div>
        </div>
    </div>
</nav>

<!-- HEADER USER -->
<div class="container user-header">
    <div class="user-avatar">
        <i class="bi bi-person-circle"></i>
    </div>
    <div class="user-header-info">
        <div class="welcome-title">Bienvenue, <%= connectedUser.getFirstName() %> !</div>
        <div class="welcome-subtitle">Accédez à vos services bancaires personnalisés.</div>
    </div>
</div>

<!-- CONTENU PRINCIPAL -->
<div class="container-fluid main-container">

    <!-- Services rapides -->
    <div class="container mb-5">
        <div class="row">
            <div class="col-12 text-center mb-4">
                <h2 class="fw-bold" style="color: #ffd600;">Services disponibles</h2>
                <p class="text-white-50">Découvrez nos services bancaires</p>
            </div>
        </div>
        <div class="row g-4 loading-animation">
            <div class="col-lg-4 col-md-6">
                <a href="<%= ctx %>/credit" class="service-card">
                    <i class="bi bi-credit-card service-icon"></i>
                    <h4 class="service-title">Mes Crédits</h4>
                    <p class="service-description">Consultez et gérez vos demandes de crédit en cours et historique</p>
                </a>
            </div>
            <div class="col-lg-4 col-md-6">
                <a href="#" class="service-card">
                    <i class="bi bi-graph-up service-icon"></i>
                    <h4 class="service-title">Mes Finances</h4>
                    <p class="service-description">Suivez l'évolution de vos comptes et vos investissements</p>
                </a>
            </div>
            <div class="col-lg-4 col-md-6">
                <a href="#" class="service-card">
                    <i class="bi bi-telephone service-icon"></i>
                    <h4 class="service-title">Support Client</h4>
                    <p class="service-description">Contactez notre équipe pour toute assistance personnalisée</p>
                </a>
            </div>
        </div>
    </div>

    <!-- Statistiques utilisateur -->
    <div class="container mb-5">
        <div class="user-stats loading-animation">
            <div class="row">
                <div class="col-12 text-center mb-3">
                    <h3 class="fw-bold" style="color: #ffd600;">Votre profil en un coup d'œil</h3>
                </div>
            </div>
            <div class="row">
                <div class="col-md-4">
                    <div class="stat-item">
                        <span class="stat-number">0</span>
                        <div class="stat-label">Crédits actifs</div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="stat-item">
                        <span class="stat-number">0</span>
                        <div class="stat-label">Demandes en cours</div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="stat-item">
                        <span class="stat-number" id="memberSince">2025</span>
                        <div class="stat-label">Membre depuis</div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Actions rapides -->
    <div class="container mb-5">
        <div class="dashboard-card loading-animation">
            <div class="row p-4">
                <div class="col-12 text-center mb-4">
                    <h3 class="fw-bold" style="color: #ffd600;">
                        <i class="bi bi-lightning-fill text-warning me-2"></i>Actions Rapides
                    </h3>
                </div>
                <div class="col-md-6 mb-3">
                    <a href="<%= ctx %>/credit" class="btn btn-outline-light w-100 p-3">
                        <i class="bi bi-plus-circle me-2"></i>
                        <strong>Nouvelle Demande de Crédit</strong>
                    </a>
                </div>
                <div class="col-md-6 mb-3">
                    <a href="#" class="btn btn-outline-light w-100 p-3">
                        <i class="bi bi-file-earmark-text me-2"></i>
                        <strong>Mes Documents</strong>
                    </a>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- FOOTER -->
<footer class="footer">
    <div class="container">
        <div class="row align-items-center">
            <div class="col-md-6">
                <span class="text-muted">
                    <strong style="color: #ffd600;">Bankati</strong> © 2025 - Tous droits réservés
                </span>
            </div>
            <div class="col-md-6 text-end">
                <small class="text-muted">Dernière connexion: <%= new java.util.Date() %></small>
            </div>
        </div>
    </div>
</footer>

<script>
    document.addEventListener('DOMContentLoaded', function() {
        // Animation des cartes/services
        const loadingElements = document.querySelectorAll('.loading-animation');
        loadingElements.forEach((element, index) => {
            setTimeout(() => {
                element.style.opacity = '1';
                element.style.transform = 'translateY(0)';
            }, index * 300);
        });
        // Animation dashboard
        const dashboardCards = document.querySelectorAll('.dashboard-card');
        dashboardCards.forEach((card, index) => {
            setTimeout(() => {
                card.style.opacity = '1';
                card.style.transform = 'translateY(0)';
            }, (index + 2) * 200);
        });
        animateStats();
    });
    function animateStats() {
        const statNumbers = document.querySelectorAll('.stat-number');
        statNumbers.forEach(stat => {
            if (stat.id === 'memberSince') return;
            const finalValue = parseInt(stat.textContent) || 0;
            let currentValue = 0;
            const increment = Math.max(1, Math.ceil(finalValue / 50));
            const timer = setInterval(() => {
                currentValue += increment;
                if (currentValue >= finalValue) {
                    currentValue = finalValue;
                    clearInterval(timer);
                }
                stat.textContent = currentValue;
            }, 30);
        });
    }
    // Hover effet (déjà stylisé sur la card CSS, mais smooth en JS aussi)
    document.querySelectorAll('.service-card').forEach(card => {
        card.addEventListener('mouseenter', function() {
            this.style.transform = 'translateY(-8px) scale(1.02)';
        });
        card.addEventListener('mouseleave', function() {
            this.style.transform = 'translateY(0) scale(1)';
        });
    });
</script>
</body>
</html>
