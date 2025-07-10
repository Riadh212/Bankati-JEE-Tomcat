<!DOCTYPE html>
<html lang="fr">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Bankati - Connexion</title>

  <link rel="stylesheet" href="<%= request.getContextPath() %>/assets/css/bootstrap.min.css">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" rel="stylesheet">
  <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">

  <style>
    /* === Palette de couleurs personnalisée fintech pastel === */
    :root {
      --main-bg1: #43cea2;     /* vert d’eau pastel */
      --main-bg2: #185a9d;     /* bleu profond */
      --brand-gradient: linear-gradient(135deg, var(--main-bg2), var(--main-bg1));
      --brand-gradient-reverse: linear-gradient(135deg, var(--main-bg1), var(--main-bg2));
      --brand-shadow: 67, 206, 162;
      --accent-color: #ffd600;
      --brand-dark: #11416c;
    }

    * { margin: 0; padding: 0; box-sizing: border-box; }

    body {
      font-family: 'Inter', sans-serif;
      height: 100vh;
      background:
              var(--brand-gradient),
              url('data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 1000 1000"><defs><linearGradient id="bg" x1="0%" y1="0%" x2="100%" y2="100%"><stop offset="0%" style="stop-color:%2343cea2;stop-opacity:1" /><stop offset="100%" style="stop-color:%23185a9d;stop-opacity:1" /></linearGradient></defs><rect width="1000" height="1000" fill="url(%23bg)"/><g opacity="0.07"><circle cx="200" cy="200" r="100" fill="white"/><circle cx="800" cy="300" r="150" fill="white"/><circle cx="400" cy="700" r="80" fill="white"/><circle cx="700" cy="800" r="120" fill="white"/><rect x="100" y="500" width="200" height="100" rx="10" fill="white"/><rect x="600" y="100" width="250" height="120" rx="15" fill="white"/></g></svg>');
      background-size: cover;
      background-position: center;
      background-attachment: fixed;
      display: flex;
      align-items: center;
      justify-content: center;
      position: relative;
      overflow: hidden;
    }
    body::before {
      content: '';
      position: absolute;
      top: 0; left: 0; right: 0; bottom: 0;
      background-image:
              radial-gradient(circle at 20% 20%, rgba(255,255,255,0.10) 1px, transparent 1px),
              radial-gradient(circle at 80% 30%, rgba(255,255,255,0.08) 1px, transparent 1px),
              radial-gradient(circle at 40% 70%, rgba(255,255,255,0.06) 1px, transparent 1px),
              radial-gradient(circle at 90% 80%, rgba(255,255,255,0.10) 1px, transparent 1px);
      background-size: 200px 200px, 300px 300px, 250px 250px, 180px 180px;
      animation: float 20s infinite linear;
      pointer-events: none;
    }
    @keyframes float {
      0%   { transform: translate(0,0); }
      25%  { transform: translate(5px,-10px); }
      50%  { transform: translate(-5px,-5px); }
      75%  { transform: translate(3px,-15px); }
      100% { transform: translate(0,0); }
    }

    /* Container & carte */
    .login-container {
      width: 95%; max-width: 400px; z-index: 10;
    }
    .login-card {
      background: rgba(255,255,255,0.97);
      backdrop-filter: blur(16px);
      border-radius: 1.25rem;
      padding: 2.2rem 2rem;
      box-shadow: 0 25px 60px rgba(var(--brand-shadow), 0.18);
      animation: slideUp 0.8s cubic-bezier(.68,-0.55,.27,1.55);
      transition: transform .3s, box-shadow .3s;
    }
    .login-card:hover {
      transform: translateY(-5px) scale(1.015);
      box-shadow: 0 35px 80px rgba(var(--brand-shadow),0.28);
    }
    @keyframes slideUp {
      from { opacity: 0; transform: translateY(50px); }
      to   { opacity: 1; transform: translateY(0); }
    }

    /* Branding header */
    .brand-header { text-align: center; margin-bottom: 1.5rem; }
    .brand-logo {
      width: 62px; height: 62px; margin: 0 auto .8rem;
      background: var(--brand-gradient-reverse);
      border-radius: 1rem;
      display: flex; align-items: center; justify-content: center;
      box-shadow: 0 8px 25px rgba(var(--brand-shadow), 0.25);
      animation: pulse 2s infinite;
    }
    @keyframes pulse {
      0%,100% { transform: scale(1);}
      50%     { transform: scale(1.07);}
    }
    .brand-logo i { font-size: 2.1rem; color: white; }
    .brand-title {
      font-size: 2.1rem; font-weight: 700;
      color: var(--brand-dark); margin-bottom: .2rem;
      letter-spacing: -.5px;
    }
    .brand-subtitle {
      color: #666; font-weight: 400; font-size: .98rem;
    }

    /* Form groups & animations */
    .form-group {
      margin-bottom: 1.08rem;
      opacity: 0; animation: fadeInUp .6s ease-out forwards;
    }
    .form-group:nth-child(1) { animation-delay: .2s; }
    .form-group:nth-child(2) { animation-delay: .42s; }
    .form-group:nth-child(3) { animation-delay: .58s; }
    .form-group:nth-child(4) { animation-delay: .74s; }
    @keyframes fadeInUp {
      from { opacity: 0; transform: translateY(24px);}
      to   { opacity: 1; transform: translateY(0);}
    }

    /* Inputs styles */
    .input-group {
      background: #f4fbfa;
      border: 2px solid transparent;
      border-radius: 1rem;
      overflow: hidden;
      transition: all .25s;
    }
    .input-group:focus-within {
      background: #fff;
      border-color: var(--main-bg2);
      box-shadow: 0 0 0 3px rgba(var(--brand-shadow),0.13);
    }
    .input-group-text {
      background: transparent; border: none;
      padding: .85rem 1.15rem; color: #5d7488;
    }
    .form-control {
      border: none; background: transparent;
      padding: .85rem 1.15rem;
      font-size: 1.03rem; color: #2d3c41;
    }
    .form-control::placeholder { color: #90a4ae; }

    /* Messages d’erreur */
    .global-message {
      background: #fbeedb;
      border: 1px solid #ffd600;
      color: #a78704;
      padding: .85rem;
      border-radius: .7rem;
      text-align: center;
      margin-bottom: 1rem;
      font-size: .95rem;
    }
    .error-message {
      display: block;
      color: #d50000;
      font-size: .88rem;
      margin-top: .32rem;
    }

    /* Bouton login animé */
    .btn-login {
      width: 100%;
      padding: .82rem;
      font-weight: 600;
      color: #fff;
      background: var(--brand-gradient);
      border: none; border-radius: 1rem;
      font-size: 1.06rem;
      position: relative; overflow: hidden;
      transition: transform .2s, background .3s;
      box-shadow: 0 2px 12px rgba(var(--brand-shadow),0.07);
    }
    .btn-login::before {
      content: '';
      position: absolute; inset: 0;
      background: linear-gradient(90deg, transparent, rgba(255,255,255,0.16), transparent);
      transform: translateX(-100%);
      transition: transform .5s;
    }
    .btn-login:hover::before { transform: translateX(100%);}
    .btn-login:hover {
      background: var(--brand-gradient-reverse);
      transform: translateY(-2px) scale(1.01);
      box-shadow: 0 6px 20px rgba(var(--brand-shadow),0.17);
    }
    .btn-login:active { transform: translateY(0); }

    /* Responsive */
    @media (max-width: 576px) {
      .login-card { padding: 1.5rem;}
      .brand-title { font-size: 1.7rem;}
    }
  </style>
</head>
<body>
<div class="login-container">
  <div class="login-card">
    <div class="brand-header">
      <div class="brand-logo">
        <i class="bi bi-bank"></i>
      </div>
      <h1 class="brand-title">Bankati</h1>
      <p class="brand-subtitle">Bankati,la confiance au coeur de votre experience digitale</p>
    </div>

    <form action="login" method="post" autocomplete="off">
      <% if (request.getAttribute("globalMessage") != null) { %>
      <div class="global-message">
        <%= request.getAttribute("globalMessage") %>
      </div>
      <% } %>

      <!-- Champ nom d'utilisateur -->
      <div class="form-group">
        <div class="input-group">
          <span class="input-group-text">
            <i class="bi bi-person-fill"></i>
          </span>
          <input type="text"
                 class="form-control"
                 name="lg"
                 placeholder="Nom d'utilisateur"
                 autocomplete="off">
        </div>
        <% if (request.getAttribute("usernameError") != null) { %>
        <span class="error-message">
          <%= request.getAttribute("usernameError") %>
        </span>
        <% } %>
      </div>

      <!-- Champ mot de passe -->
      <div class="form-group">
        <div class="input-group">
          <span class="input-group-text">
            <i class="bi bi-lock-fill"></i>
          </span>
          <input type="password"
                 class="form-control"
                 name="pss"
                 placeholder="Mot de passe"
                 autocomplete="off">
        </div>
        <% if (request.getAttribute("passwordError") != null) { %>
        <span class="error-message">
          <%= request.getAttribute("passwordError") %>
        </span>
        <% } %>
      </div>

      <!-- Bouton de connexion -->
      <div class="form-group">
        <button type="submit" class="btn btn-login">
          <i class="bi bi-box-arrow-in-right me-2"></i>
          Se connecter
        </button>
      </div>
    </form>
  </div>
</div>
</body>
</html>
