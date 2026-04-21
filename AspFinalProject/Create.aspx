<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Create.aspx.cs" Inherits="AspFinalProject.Create" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Marketplace – Create Account</title>
    <link href="https://fonts.googleapis.com/css2?family=DM+Sans:wght@300;400;500;600&family=Syne:wght@700;800&display=swap" rel="stylesheet" />
    <style>
        *, *::before, *::after {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
        }

        :root {
            --blue-dark:    #0a1628;
            --blue-mid:     #0e2a52;
            --blue-accent:  #1a6fff;
            --cyan-glow:    #00d4ff;
            --teal-soft:    #0ff0c0;
            --white:        #ffffff;
            --glass-bg:     rgba(255, 255, 255, 0.07);
            --glass-border: rgba(255, 255, 255, 0.15);
            --input-bg:     rgba(255, 255, 255, 0.06);
            --input-border: rgba(0, 212, 255, 0.3);
            --shadow-card:  0 32px 80px rgba(0, 0, 0, 0.5), 0 0 0 1px rgba(255,255,255,0.05);
        }

        html, body {
            height: 100%;
            font-family: 'DM Sans', sans-serif;
            background: var(--blue-dark);
            overflow-x: hidden;
            overflow-y: auto;
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
        .orb-2 { width: 320px; height: 320px; background: var(--cyan-glow);   bottom: -60px; right: -60px; animation-duration: 10s; animation-delay: -5s; }
        .orb-3 { width: 200px; height: 200px; background: var(--teal-soft);   top: 50%; left: 55%; animation-duration: 8s; animation-delay: -3s; }

        @keyframes drift {
            from { transform: translate(0, 0) scale(1); }
            to   { transform: translate(30px, -40px) scale(1.1); }
        }

        /* ── Page layout ── */
        .page-wrapper {
            position: relative;
            z-index: 1;
            min-height: 100vh;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            padding: 40px 24px;
        }

        /* ── Brand header ── */
        .brand {
            display: flex;
            align-items: center;
            gap: 14px;
            margin-bottom: 32px;
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

        .brand-text { display: flex; flex-direction: column; }

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

        /* ── Card ── */
        .register-card {
            width: 100%;
            max-width: 460px;
            background: var(--glass-bg);
            border: 1px solid var(--glass-border);
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
            margin-bottom: 28px;
            font-weight: 300;
        }

        /* ── Two-column grid for username + email ── */
        .fields-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 16px;
        }

        .field-full { grid-column: 1 / -1; }

        /* ── Field groups ── */
        .field-group { margin-bottom: 0; }

        .field-label {
            display: block;
            font-size: 11px;
            font-weight: 500;
            letter-spacing: 0.08em;
            text-transform: uppercase;
            color: rgba(255,255,255,0.5);
            margin-bottom: 7px;
        }

        .field-wrap { position: relative; }

        .field-icon {
            position: absolute;
            left: 13px;
            top: 50%;
            transform: translateY(-50%);
            color: rgba(0,212,255,0.5);
            font-size: 14px;
            pointer-events: none;
        }

        .field-wrap input[type="text"],
        .field-wrap input[type="password"],
        .field-wrap input[type="email"],
        .field-wrap input.text-input {
            width: 100%;
            background: var(--input-bg);
            border: 1px solid var(--input-border);
            border-radius: 12px;
            padding: 12px 13px 12px 40px;
            font-family: 'DM Sans', sans-serif;
            font-size: 14px;
            color: var(--white);
            outline: none;
            transition: border-color 0.25s, box-shadow 0.25s, background 0.25s;
        }

        .field-wrap input:focus {
            border-color: var(--cyan-glow);
            background: rgba(0,212,255,0.06);
            box-shadow: 0 0 0 3px rgba(0,212,255,0.12), 0 0 20px rgba(0,212,255,0.06);
        }

        .field-wrap input::placeholder { color: rgba(255,255,255,0.18); }

        .eye-toggle {
            position: absolute;
            right: 12px;
            top: 50%;
            transform: translateY(-50%);
            background: none;
            border: none;
            cursor: pointer;
            color: rgba(255,255,255,0.3);
            font-size: 14px;
            padding: 4px;
            transition: color 0.2s;
        }
        .eye-toggle:hover { color: var(--cyan-glow); }

        /* Password strength bar */
        .strength-wrap {
            margin-top: 8px;
            display: flex;
            gap: 4px;
        }
        .strength-seg {
            flex: 1;
            height: 3px;
            border-radius: 99px;
            background: rgba(255,255,255,0.1);
            transition: background 0.3s;
        }

        /* ── Spacer between grid and full-width rows ── */
        .field-spacer { margin-top: 16px; }

        /* ── Create button ── */
        .btn-create {
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
            background: linear-gradient(135deg, #0ff0c0 0%, #00aaff 100%);
            box-shadow: 0 4px 24px rgba(15,240,192,0.35), 0 1px 0 rgba(255,255,255,0.1) inset;
            margin-top: 26px;
            transition: transform 0.15s, box-shadow 0.15s, filter 0.15s;
            position: relative;
            overflow: hidden;
        }
        .btn-create::after {
            content: '';
            position: absolute;
            inset: 0;
            background: linear-gradient(to bottom, rgba(255,255,255,0.08), transparent);
            border-radius: 12px;
        }
        .btn-create:hover {
            transform: translateY(-1px);
            box-shadow: 0 8px 32px rgba(15,240,192,0.45);
            filter: brightness(1.06);
        }
        .btn-create:active {
            transform: translateY(1px);
            box-shadow: 0 2px 12px rgba(15,240,192,0.25);
        }

        /* ── Validation label ── */
        .msg-label {
            display: block;
            text-align: center;
            font-size: 13px;
            font-weight: 500;
            color: #ff6b6b;
            margin-top: 14px;
            min-height: 18px;
        }

        /* ── Divider + login link ── */
        .divider {
            display: flex;
            align-items: center;
            gap: 12px;
            margin: 26px 0 18px;
        }
        .divider-line { flex: 1; height: 1px; background: rgba(255,255,255,0.1); }
        .divider-text { font-size: 11px; color: rgba(255,255,255,0.25); letter-spacing: 0.1em; text-transform: uppercase; }

        .login-wrap { text-align: center; }
        .login-hint { font-size: 13px; color: rgba(255,255,255,0.4); }
        .login-link-btn {
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
            transition: color 0.2s;
        }
        .login-link-btn:hover { color: var(--white); }

        @media (max-width: 480px) {
            .register-card { padding: 36px 22px 28px; }
            .fields-grid { grid-template-columns: 1fr; }
            .field-full { grid-column: 1; }
        }
    </style>
</head>
<body>

    <div class="bg-canvas"></div>
    <div class="orb orb-1"></div>
    <div class="orb orb-2"></div>
    <div class="orb orb-3"></div>

    <form id="form1" runat="server">
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
            <div class="register-card">

                <p class="card-title">Create your account</p>
                <p class="card-sub">Join the marketplace — it only takes a minute</p>

                <div class="fields-grid">

                    <!-- Username -->
                    <div class="field-group">
                        <label class="field-label" for="txtName">Username</label>
                        <div class="field-wrap">
                            <span class="field-icon">👤</span>
                            <asp:TextBox ID="txtName" runat="server"
                                CssClass="text-input"
                                placeholder="Username"
                                BorderStyle="None"
                                Width="100%">
                            </asp:TextBox>
                        </div>
                    </div>

                    <!-- Email -->
                    <div class="field-group">
                        <label class="field-label" for="txtEmail">Email Address</label>
                        <div class="field-wrap">
                            <span class="field-icon">✉️</span>
                            <asp:TextBox ID="txtEmail" runat="server"
                                CssClass="text-input"
                                placeholder="you@email.com"
                                BorderStyle="None"
                                Width="100%">
                            </asp:TextBox>
                        </div>
                    </div>

                    <!-- Create Password -->
                    <div class="field-group field-full field-spacer">
                        <label class="field-label" for="txtCPass">Create a Password</label>
                        <div class="field-wrap">
                            <span class="field-icon">🔒</span>
                            <asp:TextBox ID="txtCPass" runat="server"
                                TextMode="Password"
                                CssClass="text-input"
                                placeholder="Create a strong password"
                                BorderStyle="None"
                                Width="100%"
                                onkeyup="checkStrength(this.value)">
                            </asp:TextBox>
                            <button type="button" class="eye-toggle" onclick="togglePwd(this)">👁</button>
                        </div>
                        <div class="strength-wrap">
                            <div class="strength-seg" id="seg1"></div>
                            <div class="strength-seg" id="seg2"></div>
                            <div class="strength-seg" id="seg3"></div>
                            <div class="strength-seg" id="seg4"></div>
                        </div>
                    </div>

                    <!-- Confirm Password -->
                    <div class="field-group field-full">
                        <label class="field-label" for="txtConfirm">Confirm Password</label>
                        <div class="field-wrap">
                            <span class="field-icon">🔐</span>
                            <asp:TextBox ID="txtConfirm" runat="server"
                                TextMode="Password"
                                CssClass="text-input"
                                placeholder="Repeat your password"
                                BorderStyle="None"
                                Width="100%">
                            </asp:TextBox>
                            <button type="button" class="eye-toggle" onclick="togglePwd(this)">👁</button>
                        </div>
                    </div>

                </div><!-- /fields-grid -->

                <!-- Create button -->
                <asp:Button ID="bttnCreate" runat="server"
                    OnClick="bttnCreate_Click"
                    Text="Create Account"
                    CssClass="btn-create"
                    UseSubmitBehavior="true" />

                <!-- Validation message -->
                <asp:Label ID="lblValidation" runat="server" CssClass="msg-label" Font-Bold="True"></asp:Label>

                <!-- Divider + login link -->
                <div class="divider">
                    <div class="divider-line"></div>
                    <span class="divider-text">Have an account?</span>
                    <div class="divider-line"></div>
                </div>

                <div class="login-wrap">
                    <span class="login-hint">Already registered? </span>
                    <asp:LinkButton ID="lbLogin" runat="server"
                        OnClick="login_Click"
                        CssClass="login-link-btn">
                        Sign in here
                    </asp:LinkButton>
                </div>

            </div><!-- /register-card -->

        </div><!-- /page-wrapper -->
    </form>

    <script>
        function togglePwd(btn) {
            const input = btn.closest('.field-wrap').querySelector('input');
            if (!input) return;
            input.type = input.type === 'password' ? 'text' : 'password';
            btn.textContent = input.type === 'password' ? '👁' : '🙈';
        }

        function checkStrength(val) {
            const segs = [
                document.getElementById('seg1'),
                document.getElementById('seg2'),
                document.getElementById('seg3'),
                document.getElementById('seg4')
            ];
            let score = 0;
            if (val.length >= 6)  score++;
            if (val.length >= 10) score++;
            if (/[A-Z]/.test(val) && /[0-9]/.test(val)) score++;
            if (/[^A-Za-z0-9]/.test(val)) score++;

            const colors = ['#ff4d4d', '#ffaa00', '#4ddfff', '#0ff0c0'];
            segs.forEach((s, i) => {
                s.style.background = i < score ? colors[score - 1] : 'rgba(255,255,255,0.1)';
            });
        }
    </script>

</body>
</html>