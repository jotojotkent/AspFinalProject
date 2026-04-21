<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="AspFinalProject.Login" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Marketplace – Login</title>
    <link href="https://fonts.googleapis.com/css2?family=DM+Sans:wght@300;400;500;600&family=Syne:wght@700;800&display=swap" rel="stylesheet" />
    <style>
        *, *::before, *::after {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
        }

        :root {
            --blue-dark:   #0a1628;
            --blue-mid:    #0e2a52;
            --blue-accent: #1a6fff;
            --cyan-glow:   #00d4ff;
            --teal-soft:   #0ff0c0;
            --white:       #ffffff;
            --glass-bg:    rgba(255, 255, 255, 0.07);
            --glass-border:rgba(255, 255, 255, 0.15);
            --input-bg:    rgba(255, 255, 255, 0.06);
            --input-border:rgba(0, 212, 255, 0.3);
            --shadow-card: 0 32px 80px rgba(0, 0, 0, 0.5), 0 0 0 1px rgba(255,255,255,0.05);
        }

        /* FIX 1: Removed overflow: hidden so the page can scroll */
        html, body {
            height: 100%;
            font-family: 'DM Sans', sans-serif;
            background: var(--blue-dark);
        }

        /* ── Animated background ── */
        .bg-canvas {
            position: fixed;
            inset: 0;
            background:
                radial-gradient(ellipse 80% 60% at 20% 10%, rgba(26,111,255,0.35) 0%, transparent 60%),
                radial-gradient(ellipse 60% 50% at 80% 90%, rgba(0,212,255,0.25) 0%, transparent 55%),
                radial-gradient(ellipse 50% 70% at 60% 40%, rgba(15,240,192,0.10) 0%, transparent 50%),
                linear-gradient(160deg, #081020 0%, #0b1f45 50%, #071530 100%);
            z-index: 0;
        }

        .bg-canvas::before {
            content: '';
            position: absolute;
            inset: 0;
            background-image:
                radial-gradient(circle at 15% 25%, rgba(0,212,255,0.08) 0, transparent 320px),
                radial-gradient(circle at 85% 70%, rgba(26,111,255,0.12) 0, transparent 400px);
            animation: pulse-glow 6s ease-in-out infinite alternate;
        }

        @keyframes pulse-glow {
            from { opacity: 0.6; }
            to   { opacity: 1; }
        }

        /* floating orbs */
        .orb {
            position: fixed;
            border-radius: 50%;
            filter: blur(60px);
            opacity: 0.18;
            animation: drift 12s ease-in-out infinite alternate;
            z-index: 0;
            pointer-events: none;
        }
        .orb-1 { width: 420px; height: 420px; background: var(--blue-accent); top: -100px; left: -80px; animation-duration: 14s; }
        .orb-2 { width: 320px; height: 320px; background: var(--cyan-glow);  bottom: -60px; right: -60px; animation-duration: 10s; animation-delay: -5s; }
        .orb-3 { width: 200px; height: 200px; background: var(--teal-soft);  top: 50%;  left: 55%; animation-duration: 8s; animation-delay: -3s; }

        @keyframes drift {
            from { transform: translate(0, 0) scale(1); }
            to   { transform: translate(30px, -40px) scale(1.1); }
        }

        /* ── Page layout ── */
        /* FIX 2: Removed fixed top/left/height values; use min-height only */
        .page-wrapper {
            position: relative;
            z-index: 1;
            min-height: 100vh;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            padding: 24px;
        }

        /* ── Brand header ── */
        .brand {
            display: flex;
            align-items: center;
            gap: 14px;
            margin-bottom: 36px;
            animation: slide-down 0.7s cubic-bezier(0.22, 1, 0.36, 1) both;
        }

        .brand-icon {
            width: 54px;
            height: 54px;
            background: linear-gradient(135deg, var(--blue-accent) 0%, var(--cyan-glow) 100%);
            border-radius: 16px;
            display: flex;
            align-items: center;
            justify-content: center;
            box-shadow: 0 0 24px rgba(0,212,255,0.45);
            font-size: 24px;
        }

        .brand-text {
            display: flex;
            flex-direction: column;
        }

        .brand-name {
            font-family: 'Syne', sans-serif;
            font-size: 26px;
            font-weight: 800;
            color: var(--white);
            letter-spacing: 0.04em;
            line-height: 1;
        }

        .brand-tagline {
            font-size: 12px;
            font-weight: 300;
            color: var(--cyan-glow);
            letter-spacing: 0.12em;
            text-transform: uppercase;
            margin-top: 4px;
        }

        /* ── Login card ── */
        /* FIX 3: Removed fixed height: 562px so card expands to fit all content */
        .login-card {
            width: 100%;
            max-width: 420px;
            border-radius: 24px;
            padding: 44px 40px 36px;
            backdrop-filter: blur(28px) saturate(150%);
            -webkit-backdrop-filter: blur(28px) saturate(150%);
            box-shadow: var(--shadow-card);
            animation: slide-up 0.8s cubic-bezier(0.22, 1, 0.36, 1) 0.1s both;
        }

        @keyframes slide-up {
            from { opacity: 0; transform: translateY(28px); }
            to   { opacity: 1; transform: translateY(0); }
        }

        @keyframes slide-down {
            from { opacity: 0; transform: translateY(-20px); }
            to   { opacity: 1; transform: translateY(0); }
        }

        .card-title {
            font-family: 'Syne', sans-serif;
            font-size: 22px;
            font-weight: 700;
            color: var(--white);
            margin-bottom: 6px;
            letter-spacing: 0.01em;
        }

        .card-sub {
            font-size: 13px;
            color: rgba(255,255,255,0.45);
            margin-bottom: 32px;
            font-weight: 300;
        }

        /* ── Field groups ── */
        .field-group {
            margin-bottom: 20px;
        }

        .field-label {
            display: block;
            font-size: 12px;
            font-weight: 500;
            letter-spacing: 0.08em;
            text-transform: uppercase;
            color: rgba(255,255,255,0.55);
            margin-bottom: 8px;
        }

        .field-wrap {
            position: relative;
        }

        .field-icon {
            position: absolute;
            left: 14px;
            top: 50%;
            transform: translateY(-50%);
            color: rgba(0,212,255,0.5);
            font-size: 15px;
            pointer-events: none;
            transition: color 0.2s;
        }

        /* ASP TextBox becomes <input> */
        .field-wrap input[type="text"],
        .field-wrap input[type="password"],
        .field-wrap input.text-input {
            width: 100%;
            background: var(--input-bg);
            border: 1px solid var(--input-border);
            border-radius: 12px;
            padding: 13px 14px 13px 42px;
            font-family: 'DM Sans', sans-serif;
            font-size: 15px;
            color: var(--white);
            outline: none;
            transition: border-color 0.25s, box-shadow 0.25s, background 0.25s;
        }

        .field-wrap input[type="text"]:focus,
        .field-wrap input[type="password"]:focus,
        .field-wrap input.text-input:focus {
            border-color: var(--cyan-glow);
            background: rgba(0,212,255,0.06);
            box-shadow: 0 0 0 3px rgba(0,212,255,0.12), 0 0 20px rgba(0,212,255,0.08);
        }

        .field-wrap input::placeholder {
            color: rgba(255,255,255,0.2);
        }

        /* Eye toggle for password */
        .eye-toggle {
            position: absolute;
            right: 14px;
            top: 50%;
            transform: translateY(-50%);
            background: none;
            border: none;
            cursor: pointer;
            color: rgba(255,255,255,0.3);
            font-size: 15px;
            padding: 4px;
            transition: color 0.2s;
        }
        .eye-toggle:hover { color: var(--cyan-glow); }

        /* ── Login button ── */
        .btn-login {
            width: 100%;
            padding: 14px;
            border-radius: 12px;
            border: none;
            cursor: pointer;
            font-family: 'DM Sans', sans-serif;
            font-size: 15px;
            font-weight: 600;
            letter-spacing: 0.04em;
            color: var(--white);
            background: linear-gradient(135deg, var(--blue-accent) 0%, #0099dd 100%);
            box-shadow: 0 4px 24px rgba(26,111,255,0.45), 0 1px 0 rgba(255,255,255,0.1) inset;
            margin-top: 28px;
            transition: transform 0.15s, box-shadow 0.15s, filter 0.15s;
            position: relative;
            overflow: hidden;
        }

        .btn-login::after {
            content: '';
            position: absolute;
            inset: 0;
            background: linear-gradient(to bottom, rgba(255,255,255,0.08), transparent);
            border-radius: 12px;
        }

        .btn-login:hover {
            transform: translateY(-1px);
            box-shadow: 0 8px 32px rgba(26,111,255,0.55), 0 1px 0 rgba(255,255,255,0.12) inset;
            filter: brightness(1.08);
        }

        .btn-login:active {
            transform: translateY(1px);
            box-shadow: 0 2px 12px rgba(26,111,255,0.35);
        }

        /* ── Message label ── */
        .msg-label {
            display: block;
            text-align: center;
            font-size: 13px;
            font-weight: 500;
            color: #ff6b6b;
            margin-top: 14px;
            min-height: 18px;
            letter-spacing: 0.01em;
        }

        /* ── Divider ── */
        .divider {
            display: flex;
            align-items: center;
            gap: 12px;
            margin: 28px 0 20px;
        }
        .divider-line { flex: 1; height: 1px; background: rgba(255,255,255,0.1); }
        .divider-text { font-size: 11px; color: rgba(255,255,255,0.25); letter-spacing: 0.1em; text-transform: uppercase; }

        /* ── Register link ── */
        .register-wrap {
            text-align: center;
        }

        .register-link {
            font-size: 13px;
            color: rgba(255,255,255,0.4);
            text-decoration: none;
        }

        .register-link-btn {
            background: none;
            border: none;
            font-family: 'DM Sans', sans-serif;
            font-size: 13px;
            font-weight: 600;
            color: var(--cyan-glow);
            cursor: pointer;
            text-decoration: underline;
            text-underline-offset: 3px;
            padding: 0;
            transition: color 0.2s, opacity 0.2s;
        }
        .register-link-btn:hover { color: var(--white); opacity: 0.9; }

        /* ASP Panel hidden helper */
        #Panel1 { display: none; }

        /* Responsive tweak */
        @media (max-width: 480px) {
            .login-card { padding: 36px 24px 28px; }
            .brand-name { font-size: 22px; }
        }
    </style>
</head>
<body>

    <!-- Animated background layers -->
    <div class="bg-canvas"></div>
    <div class="orb orb-1"></div>
    <div class="orb orb-2"></div>
    <div class="orb orb-3"></div>

    <form id="form1" runat="server">

        <asp:Panel ID="Panel1" runat="server"></asp:Panel>

        <div class="page-wrapper">

            <!-- Brand -->
            <div class="brand">
                <div class="brand-icon">🏪</div>
                <div class="brand-text">
                    <span class="brand-name">MARKETPLACE</span>
                    <span class="brand-tagline">Local Deals • Global Reach</span>
                </div>
            </div>

            <!-- Card -->
            <div class="login-card">

                <p class="card-title">Welcome back</p>
                <p class="card-sub">Sign in to your account to continue</p>

                <!-- Username -->
                <div class="field-group">
                    <label class="field-label" for="txtUName">Username</label>
                    <div class="field-wrap">
                        <span class="field-icon">👤</span>
                        <asp:TextBox ID="txtUName" runat="server"
                            CssClass="text-input"
                            placeholder="Enter your username"
                            BorderStyle="None"
                            Width="100%">
                        </asp:TextBox>
                    </div>
                </div>

                <!-- Password -->
                <div class="field-group">
                    <label class="field-label" for="txtPWord">Password</label>
                    <div class="field-wrap">
                        <span class="field-icon">🔒</span>
                        <asp:TextBox ID="txtPWord" runat="server"
                            TextMode="Password"
                            CssClass="text-input"
                            placeholder="Enter your password"
                            BorderStyle="None"
                            Width="100%">
                        </asp:TextBox>
                        <button type="button" class="eye-toggle" onclick="togglePwd(this)" title="Show/hide password">👁</button>
                    </div>
                </div>

                <!-- Login button -->
                <asp:Button ID="bttnLogin" runat="server"
                    OnClick="bttnLogin_Click"
                    Text="Sign In"
                    CssClass="btn-login"
                    UseSubmitBehavior="true" />

                <!-- Error/message label -->
                <asp:Label ID="lblMess" runat="server" CssClass="msg-label" Font-Bold="True"></asp:Label>

                <!-- Divider -->
                <div class="divider">
                    <div class="divider-line"></div>
                    <span class="divider-text">New here?</span>
                    <div class="divider-line"></div>
                </div>

                <!-- Register link -->
                <div class="register-wrap">
                    <span class="register-link">Don't have an account yet? </span>
                    <asp:LinkButton ID="lbCreate" runat="server"
                        OnClick="createAccount_Click"
                        CssClass="register-link-btn">
                        Create account
                    </asp:LinkButton>
                </div>

            </div><!-- /login-card -->

        </div><!-- /page-wrapper -->

    </form>

    <script>
        function togglePwd(btn) {
            const card = btn.closest('.field-wrap');
            const input = card.querySelector('input');
            if (!input) return;
            if (input.type === 'password') {
                input.type = 'text';
                btn.textContent = '🙈';
            } else {
                input.type = 'password';
                btn.textContent = '👁';
            }
        }
    </script>

</body>
</html>