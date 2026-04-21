<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Dashboard.aspx.cs" Inherits="AspFinalProject.Dashboard" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Marketplace – Home</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
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
            --orange-hot:   #ff6b2b;
            --orange-light: #ff9a5c;
            --white:        #ffffff;
            --text-muted:   rgba(255,255,255,0.45);
            --glass-bg:     rgba(255,255,255,0.06);
            --glass-border: rgba(255,255,255,0.12);
            --input-bg:     rgba(255,255,255,0.08);
            --input-border: rgba(0,212,255,0.3);
            --card-bg:      rgba(14,42,82,0.55);
            --card-border:  rgba(255,255,255,0.08);
            --nav-height:   64px;
        }

        html, body {
            font-family: 'DM Sans', sans-serif;
            background: var(--blue-dark);
            color: var(--white);
            min-height: 100%;
        }

        /* ─── Scrollbar ─── */
        ::-webkit-scrollbar { width: 6px; }
        ::-webkit-scrollbar-track { background: var(--blue-dark); }
        ::-webkit-scrollbar-thumb { background: var(--blue-mid); border-radius: 3px; }

        /* ─── Background canvas ─── */
        .bg-canvas {
            position: fixed;
            inset: 0;
            background:
                radial-gradient(ellipse 80% 60% at 20% 10%, rgba(26,111,255,0.30) 0%, transparent 60%),
                radial-gradient(ellipse 60% 50% at 80% 90%, rgba(0,212,255,0.20) 0%, transparent 55%),
                linear-gradient(160deg, #081020 0%, #0b1f45 50%, #071530 100%);
            z-index: 0;
            pointer-events: none;
        }

        /* ─── Orbs ─── */
        .orb {
            position: fixed;
            border-radius: 50%;
            filter: blur(70px);
            opacity: 0.14;
            animation: drift 12s ease-in-out infinite alternate;
            z-index: 0;
            pointer-events: none;
        }
        .orb-1 { width: 500px; height: 500px; background: var(--blue-accent); top: -120px; left: -100px; animation-duration: 16s; }
        .orb-2 { width: 350px; height: 350px; background: var(--cyan-glow);  bottom: 10%; right: -80px; animation-duration: 11s; animation-delay: -5s; }
        .orb-3 { width: 250px; height: 250px; background: var(--orange-hot); top: 40%; left: 60%; animation-duration: 9s; animation-delay: -3s; opacity: 0.08; }

        @keyframes drift {
            from { transform: translate(0,0) scale(1); }
            to   { transform: translate(25px,-35px) scale(1.08); }
        }

        /* ─── Everything above bg ─── */
        #form1 { position: relative; z-index: 1; }

        /* ════════════════════════════════
           TOP NAV
        ════════════════════════════════ */
        .top-nav {
            position: sticky;
            top: 0;
            z-index: 100;
            height: var(--nav-height);
            backdrop-filter: blur(24px) saturate(160%);
            -webkit-backdrop-filter: blur(24px) saturate(160%);
            background: rgba(10,22,40,0.82);
            border-bottom: 1px solid var(--glass-border);
            display: flex;
            align-items: center;
            padding: 0 20px;
            gap: 16px;
        }

        /* Brand */
        .nav-brand {
            display: flex;
            align-items: center;
            gap: 10px;
            text-decoration: none;
            flex-shrink: 0;
        }
        .nav-brand-icon {
            width: 36px; height: 36px;
            background: linear-gradient(135deg, var(--blue-accent) 0%, var(--cyan-glow) 100%);
            border-radius: 10px;
            display: flex; align-items: center; justify-content: center;
            font-size: 18px;
            box-shadow: 0 0 14px rgba(0,212,255,0.4);
        }
        .nav-brand-name {
            font-family: 'Syne', sans-serif;
            font-size: 18px;
            font-weight: 800;
            color: var(--white);
            letter-spacing: 0.04em;
        }

        /* Search bar */
        .nav-search {
            flex: 1;
            max-width: 560px;
            position: relative;
        }
        .nav-search input {
            width: 100%;
            background: var(--input-bg);
            border: 1px solid var(--input-border);
            border-radius: 24px;
            padding: 9px 44px 9px 18px;
            font-family: 'DM Sans', sans-serif;
            font-size: 14px;
            color: var(--white);
            outline: none;
            transition: border-color 0.25s, box-shadow 0.25s;
        }
        .nav-search input::placeholder { color: rgba(255,255,255,0.25); }
        .nav-search input:focus {
            border-color: var(--cyan-glow);
            box-shadow: 0 0 0 3px rgba(0,212,255,0.12);
        }
        .nav-search-btn {
            position: absolute;
            right: 6px; top: 50%;
            transform: translateY(-50%);
            background: linear-gradient(135deg, var(--blue-accent), var(--cyan-glow));
            border: none; border-radius: 20px;
            width: 32px; height: 32px;
            display: flex; align-items: center; justify-content: center;
            cursor: pointer; font-size: 14px;
            transition: filter 0.2s;
        }
        .nav-search-btn:hover { filter: brightness(1.15); }

        /* Nav actions */
        .nav-actions {
            display: flex;
            align-items: center;
            gap: 8px;
            margin-left: auto;
            flex-shrink: 0;
        }
        .nav-icon-btn {
            position: relative;
            background: var(--glass-bg);
            border: 1px solid var(--glass-border);
            border-radius: 12px;
            width: 38px; height: 38px;
            display: flex; align-items: center; justify-content: center;
            cursor: pointer; font-size: 17px;
            transition: background 0.2s, border-color 0.2s;
            text-decoration: none;
        }
        .nav-icon-btn:hover { background: rgba(0,212,255,0.1); border-color: var(--cyan-glow); }
        .nav-badge {
            position: absolute;
            top: -4px; right: -4px;
            background: var(--orange-hot);
            color: #fff;
            font-size: 9px; font-weight: 700;
            min-width: 16px; height: 16px;
            border-radius: 8px;
            display: flex; align-items: center; justify-content: center;
            padding: 0 3px;
        }
        .nav-avatar {
            width: 38px; height: 38px;
            border-radius: 12px;
            background: linear-gradient(135deg, var(--blue-accent), var(--cyan-glow));
            display: flex; align-items: center; justify-content: center;
            font-size: 16px; cursor: pointer;
            border: 1px solid rgba(0,212,255,0.3);
            font-weight: 700; color: #fff;
            font-family: 'Syne', sans-serif;
        }

        /* ════════════════════════════════
           CATEGORY STRIP
        ════════════════════════════════ */
        .cat-strip-wrap {
            background: rgba(10,22,40,0.6);
            border-bottom: 1px solid var(--glass-border);
            backdrop-filter: blur(12px);
            overflow-x: auto;
            scrollbar-width: none;
        }
        .cat-strip-wrap::-webkit-scrollbar { display: none; }
        .cat-strip {
            display: flex;
            gap: 6px;
            padding: 10px 20px;
            width: max-content;
        }
        .cat-chip {
            display: flex;
            align-items: center;
            gap: 6px;
            padding: 7px 16px;
            border-radius: 20px;
            background: var(--glass-bg);
            border: 1px solid var(--glass-border);
            font-size: 13px;
            font-weight: 500;
            color: rgba(255,255,255,0.7);
            cursor: pointer;
            white-space: nowrap;
            transition: background 0.2s, border-color 0.2s, color 0.2s, transform 0.15s;
            text-decoration: none;
        }
        .cat-chip:hover {
            background: rgba(0,212,255,0.12);
            border-color: var(--cyan-glow);
            color: var(--white);
            transform: translateY(-1px);
        }
        .cat-chip.active {
            background: linear-gradient(135deg, var(--blue-accent), rgba(0,212,255,0.6));
            border-color: transparent;
            color: var(--white);
        }
        .cat-chip-icon { font-size: 16px; }

        /* ════════════════════════════════
           MAIN LAYOUT
        ════════════════════════════════ */
        .main-wrap {
            max-width: 1280px;
            margin: 0 auto;
            padding: 20px 20px 60px;
        }

        /* ─── Two-column layout: sidebar + content ─── */
        .layout-grid {
            display: grid;
            grid-template-columns: 220px 1fr;
            gap: 20px;
            align-items: start;
        }

        /* ════════════════════════════════
           SIDEBAR
        ════════════════════════════════ */
        .sidebar {
            position: sticky;
            top: calc(var(--nav-height) + 52px);
        }
        .sidebar-section {
            background: var(--card-bg);
            border: 1px solid var(--card-border);
            border-radius: 16px;
            padding: 16px;
            margin-bottom: 14px;
            backdrop-filter: blur(12px);
        }
        .sidebar-title {
            font-family: 'Syne', sans-serif;
            font-size: 13px;
            font-weight: 700;
            color: var(--cyan-glow);
            letter-spacing: 0.08em;
            text-transform: uppercase;
            margin-bottom: 12px;
        }
        .sidebar-link {
            display: flex;
            align-items: center;
            gap: 10px;
            padding: 9px 10px;
            border-radius: 10px;
            font-size: 13px;
            color: rgba(255,255,255,0.7);
            text-decoration: none;
            transition: background 0.2s, color 0.2s;
            cursor: pointer;
        }
        .sidebar-link:hover { background: rgba(0,212,255,0.1); color: var(--white); }
        .sidebar-link.active { background: rgba(26,111,255,0.2); color: var(--cyan-glow); }
        .sidebar-link-icon { font-size: 16px; width: 22px; text-align: center; }

        .flash-deal-tag {
            display: inline-flex;
            align-items: center;
            gap: 4px;
            background: rgba(255,107,43,0.2);
            border: 1px solid rgba(255,107,43,0.4);
            border-radius: 6px;
            font-size: 10px;
            font-weight: 600;
            color: var(--orange-light);
            padding: 2px 7px;
            margin-left: auto;
        }

        /* ════════════════════════════════
           CONTENT AREA
        ════════════════════════════════ */
        .content-area { min-width: 0; }

        /* ─── Hero Banner ─── */
        .hero-banner {
            position: relative;
            border-radius: 20px;
            overflow: hidden;
            height: 200px;
            margin-bottom: 20px;
            cursor: pointer;
        }
        .hero-slides { display: flex; height: 100%; transition: transform 0.5s cubic-bezier(0.4,0,0.2,1); }
        .hero-slide {
            min-width: 100%; height: 100%;
            display: flex; align-items: center;
            padding: 28px 36px;
            position: relative;
            overflow: hidden;
        }
        .hero-slide-1 {
            background: linear-gradient(120deg, #0e2a52 0%, #1a6fff 50%, #00d4ff 100%);
        }
        .hero-slide-2 {
            background: linear-gradient(120deg, #1a0a00 0%, #ff6b2b 50%, #ff9a5c 100%);
        }
        .hero-slide-3 {
            background: linear-gradient(120deg, #001a1a 0%, #006b5c 50%, #0ff0c0 100%);
        }
        .hero-slide::before {
            content: '';
            position: absolute; inset: 0;
            background: radial-gradient(ellipse at 80% 50%, rgba(255,255,255,0.08) 0%, transparent 60%);
        }
        .hero-content { position: relative; z-index: 1; }
        .hero-eyebrow {
            font-size: 11px; font-weight: 600;
            letter-spacing: 0.15em; text-transform: uppercase;
            color: rgba(255,255,255,0.6);
            margin-bottom: 8px;
        }
        .hero-title {
            font-family: 'Syne', sans-serif;
            font-size: 28px; font-weight: 800;
            line-height: 1.1;
            margin-bottom: 12px;
        }
        .hero-cta {
            display: inline-flex; align-items: center; gap: 6px;
            background: rgba(255,255,255,0.15);
            border: 1px solid rgba(255,255,255,0.25);
            backdrop-filter: blur(8px);
            padding: 8px 18px; border-radius: 20px;
            font-size: 13px; font-weight: 600; color: #fff;
            text-decoration: none;
            transition: background 0.2s;
        }
        .hero-cta:hover { background: rgba(255,255,255,0.25); }
        .hero-emoji {
            position: absolute;
            right: 36px; top: 50%;
            transform: translateY(-50%);
            font-size: 80px;
            opacity: 0.35;
            filter: drop-shadow(0 0 20px rgba(255,255,255,0.3));
        }

        /* Banner dots */
        .hero-dots {
            position: absolute;
            bottom: 12px; left: 50%;
            transform: translateX(-50%);
            display: flex; gap: 6px;
        }
        .hero-dot {
            width: 6px; height: 6px;
            border-radius: 3px;
            background: rgba(255,255,255,0.35);
            transition: width 0.3s, background 0.3s;
            cursor: pointer;
        }
        .hero-dot.active { width: 18px; background: #fff; }

        /* Banner arrows */
        .hero-arrow {
            position: absolute;
            top: 50%; transform: translateY(-50%);
            background: rgba(255,255,255,0.15);
            border: 1px solid rgba(255,255,255,0.2);
            border-radius: 50%;
            width: 32px; height: 32px;
            display: flex; align-items: center; justify-content: center;
            cursor: pointer; font-size: 14px;
            transition: background 0.2s;
            backdrop-filter: blur(6px);
            z-index: 5;
        }
        .hero-arrow:hover { background: rgba(255,255,255,0.28); }
        .hero-arrow-left  { left: 12px; }
        .hero-arrow-right { right: 12px; }

        /* ─── Flash Deals Bar ─── */
        .flash-bar {
            display: flex; align-items: center; gap: 12px;
            background: linear-gradient(90deg, rgba(255,107,43,0.18), rgba(255,154,92,0.08));
            border: 1px solid rgba(255,107,43,0.3);
            border-radius: 14px;
            padding: 10px 16px;
            margin-bottom: 20px;
        }
        .flash-bar-label {
            display: flex; align-items: center; gap: 6px;
            font-family: 'Syne', sans-serif;
            font-size: 14px; font-weight: 700;
            color: var(--orange-light);
        }
        .flash-timer {
            display: flex; align-items: center; gap: 4px;
            margin-left: 8px;
        }
        .timer-seg {
            background: rgba(255,107,43,0.25);
            border: 1px solid rgba(255,107,43,0.4);
            border-radius: 6px;
            padding: 2px 7px;
            font-size: 13px; font-weight: 700;
            color: var(--orange-light);
            min-width: 28px; text-align: center;
            font-family: 'Syne', sans-serif;
        }
        .timer-colon { color: var(--orange-light); font-weight: 700; font-size: 13px; }
        .flash-see-all {
            margin-left: auto;
            font-size: 12px; font-weight: 600;
            color: var(--orange-light);
            text-decoration: none;
            display: flex; align-items: center; gap: 4px;
            opacity: 0.8;
            transition: opacity 0.2s;
        }
        .flash-see-all:hover { opacity: 1; }

        /* ─── Section header ─── */
        .section-header {
            display: flex; align-items: center;
            justify-content: space-between;
            margin-bottom: 14px;
        }
        .section-title {
            font-family: 'Syne', sans-serif;
            font-size: 16px; font-weight: 700;
            display: flex; align-items: center; gap: 8px;
        }
        .section-see-all {
            font-size: 12px; font-weight: 600;
            color: var(--cyan-glow);
            text-decoration: none;
            display: flex; align-items: center; gap: 3px;
            opacity: 0.8;
            transition: opacity 0.2s;
        }
        .section-see-all:hover { opacity: 1; }

        /* ─── Product grid ─── */
        .product-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(170px, 1fr));
            gap: 14px;
            margin-bottom: 28px;
        }

        /* ─── Product card ─── */
        .product-card {
            background: var(--card-bg);
            border: 1px solid var(--card-border);
            border-radius: 16px;
            overflow: hidden;
            cursor: pointer;
            transition: transform 0.2s, box-shadow 0.2s, border-color 0.2s;
            backdrop-filter: blur(10px);
            animation: fade-in 0.5s ease both;
            text-decoration: none;
            color: inherit;
            display: block;
        }
        .product-card:hover {
            transform: translateY(-4px);
            box-shadow: 0 16px 40px rgba(0,0,0,0.4), 0 0 0 1px rgba(0,212,255,0.15);
            border-color: rgba(0,212,255,0.2);
        }

        @keyframes fade-in {
            from { opacity: 0; transform: translateY(12px); }
            to   { opacity: 1; transform: translateY(0); }
        }

        .card-img-wrap {
            position: relative;
            width: 100%; aspect-ratio: 1;
            background: rgba(255,255,255,0.04);
            overflow: hidden;
            display: flex; align-items: center; justify-content: center;
            font-size: 56px;
        }
        .card-img-wrap::after {
            content: '';
            position: absolute; inset: 0;
            background: linear-gradient(to bottom, transparent 60%, rgba(10,22,40,0.5));
        }

        .card-badge {
            position: absolute; top: 8px; left: 8px;
            background: var(--orange-hot);
            color: #fff; font-size: 10px; font-weight: 700;
            padding: 2px 7px; border-radius: 6px;
            z-index: 1;
        }
        .card-badge.new {
            background: linear-gradient(90deg, var(--blue-accent), var(--cyan-glow));
        }
        .card-wish {
            position: absolute; top: 8px; right: 8px;
            background: rgba(10,22,40,0.55);
            border: 1px solid rgba(255,255,255,0.1);
            border-radius: 8px;
            width: 28px; height: 28px;
            display: flex; align-items: center; justify-content: center;
            font-size: 14px; cursor: pointer;
            transition: background 0.2s, transform 0.2s;
            z-index: 1;
        }
        .card-wish:hover { background: rgba(255,107,43,0.3); transform: scale(1.1); }

        .card-body { padding: 10px 12px 12px; }
        .card-name {
            font-size: 13px; font-weight: 500;
            color: rgba(255,255,255,0.88);
            line-height: 1.35;
            margin-bottom: 6px;
            display: -webkit-box;
            -webkit-line-clamp: 2;
            -webkit-box-orient: vertical;
            overflow: hidden;
        }
        .card-price-row {
            display: flex; align-items: baseline; gap: 6px;
            margin-bottom: 6px;
        }
        .card-price {
            font-family: 'Syne', sans-serif;
            font-size: 15px; font-weight: 700;
            color: var(--cyan-glow);
        }
        .card-price-old {
            font-size: 11px;
            color: var(--text-muted);
            text-decoration: line-through;
        }
        .card-meta {
            display: flex; align-items: center; justify-content: space-between;
        }
        .card-rating {
            display: flex; align-items: center; gap: 3px;
            font-size: 11px; color: rgba(255,255,255,0.5);
        }
        .card-rating-star { color: #fbbf24; font-size: 11px; }
        .card-sold {
            font-size: 11px; color: var(--text-muted);
        }

        /* ─── Mini product row (flash deal horizontal) ─── */
        .flash-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(120px, 1fr));
            gap: 12px;
            margin-bottom: 28px;
        }
        .flash-card {
            background: var(--card-bg);
            border: 1px solid var(--card-border);
            border-radius: 14px;
            overflow: hidden;
            cursor: pointer;
            transition: transform 0.2s, box-shadow 0.2s;
            backdrop-filter: blur(10px);
            text-decoration: none;
            color: inherit;
        }
        .flash-card:hover {
            transform: translateY(-3px);
            box-shadow: 0 12px 30px rgba(0,0,0,0.35);
        }
        .flash-card-img {
            width: 100%; aspect-ratio: 1;
            background: rgba(255,255,255,0.04);
            display: flex; align-items: center; justify-content: center;
            font-size: 44px;
            position: relative;
        }
        .flash-card-body { padding: 8px 10px 10px; }
        .flash-card-price {
            font-family: 'Syne', sans-serif;
            font-size: 14px; font-weight: 700;
            color: var(--orange-light);
        }
        .flash-discount-bar {
            margin-top: 5px;
            height: 4px;
            border-radius: 2px;
            background: rgba(255,107,43,0.2);
            overflow: hidden;
        }
        .flash-discount-fill {
            height: 100%;
            background: linear-gradient(90deg, var(--orange-hot), var(--orange-light));
            border-radius: 2px;
        }
        .flash-sold-pct {
            font-size: 10px;
            color: var(--orange-light);
            margin-top: 3px;
            opacity: 0.75;
        }

        /* ─── Nearby listings ─── */
        .nearby-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(220px, 1fr));
            gap: 14px;
            margin-bottom: 28px;
        }
        .nearby-card {
            background: var(--card-bg);
            border: 1px solid var(--card-border);
            border-radius: 16px;
            overflow: hidden;
            cursor: pointer;
            transition: transform 0.2s, box-shadow 0.2s, border-color 0.2s;
            backdrop-filter: blur(10px);
            text-decoration: none;
            color: inherit;
            display: flex;
            gap: 0;
        }
        .nearby-card:hover {
            transform: translateY(-3px);
            box-shadow: 0 14px 36px rgba(0,0,0,0.4);
            border-color: rgba(0,212,255,0.2);
        }
        .nearby-img {
            width: 90px; min-height: 90px;
            background: rgba(255,255,255,0.04);
            display: flex; align-items: center; justify-content: center;
            font-size: 40px; flex-shrink: 0;
        }
        .nearby-body {
            padding: 12px;
            display: flex; flex-direction: column; justify-content: center;
        }
        .nearby-name {
            font-size: 13px; font-weight: 500;
            margin-bottom: 4px;
            display: -webkit-box;
            -webkit-line-clamp: 2;
            -webkit-box-orient: vertical;
            overflow: hidden;
        }
        .nearby-price {
            font-family: 'Syne', sans-serif;
            font-size: 14px; font-weight: 700;
            color: var(--cyan-glow);
            margin-bottom: 4px;
        }
        .nearby-loc {
            font-size: 11px; color: var(--text-muted);
            display: flex; align-items: center; gap: 4px;
        }

        /* ─── Sell CTA banner ─── */
        .sell-banner {
            background: linear-gradient(120deg, rgba(26,111,255,0.25) 0%, rgba(0,212,255,0.12) 100%);
            border: 1px solid rgba(0,212,255,0.2);
            border-radius: 16px;
            padding: 20px 24px;
            display: flex; align-items: center; justify-content: space-between;
            margin-bottom: 28px;
            gap: 16px;
        }
        .sell-banner-text .sell-title {
            font-family: 'Syne', sans-serif;
            font-size: 16px; font-weight: 700;
            margin-bottom: 4px;
        }
        .sell-banner-text .sell-sub {
            font-size: 13px; color: var(--text-muted);
        }
        .sell-btn {
            flex-shrink: 0;
            background: linear-gradient(135deg, var(--blue-accent), var(--cyan-glow));
            border: none; border-radius: 10px;
            padding: 10px 20px;
            font-family: 'DM Sans', sans-serif;
            font-size: 13px; font-weight: 600;
            color: #fff; cursor: pointer;
            transition: filter 0.2s, transform 0.15s;
            box-shadow: 0 4px 16px rgba(26,111,255,0.4);
        }
        .sell-btn:hover { filter: brightness(1.1); transform: translateY(-1px); }

        /* ─── Bottom nav (mobile feel) ─── */
        .bottom-nav {
            display: none;
            position: fixed; bottom: 0; left: 0; right: 0;
            z-index: 99;
            background: rgba(10,22,40,0.92);
            backdrop-filter: blur(20px);
            border-top: 1px solid var(--glass-border);
            padding: 8px 0 max(8px, env(safe-area-inset-bottom));
        }
        .bottom-nav-inner {
            display: flex; justify-content: space-around;
        }
        .bottom-nav-item {
            display: flex; flex-direction: column; align-items: center; gap: 3px;
            font-size: 10px; color: var(--text-muted);
            text-decoration: none;
            transition: color 0.2s;
            cursor: pointer;
        }
        .bottom-nav-item.active { color: var(--cyan-glow); }
        .bottom-nav-item:hover { color: var(--white); }
        .bottom-nav-icon { font-size: 20px; }

        @media (max-width: 768px) {
            .layout-grid { grid-template-columns: 1fr; }
            .sidebar { display: none; }
            .bottom-nav { display: block; }
            .main-wrap { padding-bottom: 80px; }
            .hero-banner { height: 160px; }
            .hero-title { font-size: 20px; }
            .hero-emoji { font-size: 56px; right: 20px; }
            .product-grid { grid-template-columns: repeat(auto-fill, minmax(140px, 1fr)); }
        }

        @media (max-width: 480px) {
            .top-nav { padding: 0 12px; gap: 10px; }
            .nav-brand-name { display: none; }
            .main-wrap { padding: 14px 12px 80px; }
            .flash-grid { grid-template-columns: repeat(3, 1fr); }
        }
    </style>
</head>
<body>

    <div class="bg-canvas"></div>
    <div class="orb orb-1"></div>
    <div class="orb orb-2"></div>
    <div class="orb orb-3"></div>

    <form id="form1" runat="server">

        <!-- ══════════════ TOP NAV ══════════════ -->
        <nav class="top-nav">
            <a href="#" class="nav-brand">
                <div class="nav-brand-icon">🏪</div>
                <span class="nav-brand-name">MARKETPLACE</span>
            </a>

            <div class="nav-search">
                <input type="text" placeholder="Search for products, shops, deals…" />
                <button class="nav-search-btn" type="button">🔍</button>
            </div>

            <div class="nav-actions">
                <a href="#" class="nav-icon-btn" title="Notifications">
                    🔔
                    <span class="nav-badge">3</span>
                </a>
                <a href="#" class="nav-icon-btn" title="Cart">
                    🛒
                    <span class="nav-badge">2</span>
                </a>
                <a href="#" class="nav-icon-btn" title="Messages">💬</a>
                <div class="nav-avatar">U</div>
            </div>
        </nav>

        <!-- ══════════════ CATEGORY STRIP ══════════════ -->
        <div class="cat-strip-wrap">
            <div class="cat-strip">
                <a href="#" class="cat-chip active"><span class="cat-chip-icon">🏠</span> All</a>
                <a href="#" class="cat-chip"><span class="cat-chip-icon">📱</span> Electronics</a>
                <a href="#" class="cat-chip"><span class="cat-chip-icon">👗</span> Fashion</a>
                <a href="#" class="cat-chip"><span class="cat-chip-icon">🛋️</span> Home & Living</a>
                <a href="#" class="cat-chip"><span class="cat-chip-icon">🎮</span> Gaming</a>
                <a href="#" class="cat-chip"><span class="cat-chip-icon">💄</span> Beauty</a>
                <a href="#" class="cat-chip"><span class="cat-chip-icon">🏋️</span> Sports</a>
                <a href="#" class="cat-chip"><span class="cat-chip-icon">📚</span> Books</a>
                <a href="#" class="cat-chip"><span class="cat-chip-icon">🚗</span> Automotive</a>
                <a href="#" class="cat-chip"><span class="cat-chip-icon">🌱</span> Garden</a>
                <a href="#" class="cat-chip"><span class="cat-chip-icon">🐾</span> Pets</a>
                <a href="#" class="cat-chip"><span class="cat-chip-icon">🍳</span> Food</a>
            </div>
        </div>

        <!-- ══════════════ MAIN ══════════════ -->
        <div class="main-wrap">
            <div class="layout-grid">

                <!-- ─── SIDEBAR ─── -->
                <aside class="sidebar">
                    <div class="sidebar-section">
                        <div class="sidebar-title">Browse</div>
                        <a href="#" class="sidebar-link active">
                            <span class="sidebar-link-icon">🏠</span> Today's Picks
                        </a>
                        <a href="#" class="sidebar-link">
                            <span class="sidebar-link-icon">⚡</span> Flash Deals
                            <span class="flash-deal-tag">🔥 LIVE</span>
                        </a>
                        <a href="#" class="sidebar-link">
                            <span class="sidebar-link-icon">📍</span> Near You
                        </a>
                        <a href="#" class="sidebar-link">
                            <span class="sidebar-link-icon">⭐</span> Top Rated
                        </a>
                        <a href="#" class="sidebar-link">
                            <span class="sidebar-link-icon">🆕</span> New Arrivals
                        </a>
                        <a href="#" class="sidebar-link">
                            <span class="sidebar-link-icon">❤️</span> Wishlist
                        </a>
                    </div>

                    <div class="sidebar-section">
                        <div class="sidebar-title">My Account</div>
                        <a href="#" class="sidebar-link">
                            <span class="sidebar-link-icon">📦</span> My Orders
                        </a>
                        <a href="#" class="sidebar-link">
                            <span class="sidebar-link-icon">🏪</span> My Listings
                        </a>
                        <a href="#" class="sidebar-link">
                            <span class="sidebar-link-icon">💬</span> Messages
                        </a>
                        <a href="#" class="sidebar-link">
                            <span class="sidebar-link-icon">⚙️</span> Settings
                        </a>
                    </div>

                    <div class="sidebar-section">
                        <div class="sidebar-title">Filter by Price</div>
                        <a href="#" class="sidebar-link"><span class="sidebar-link-icon">💙</span> Under ₱500</a>
                        <a href="#" class="sidebar-link"><span class="sidebar-link-icon">💙</span> ₱500 – ₱2,000</a>
                        <a href="#" class="sidebar-link"><span class="sidebar-link-icon">💙</span> ₱2,000 – ₱10,000</a>
                        <a href="#" class="sidebar-link"><span class="sidebar-link-icon">💙</span> Above ₱10,000</a>
                    </div>
                </aside>

                <!-- ─── CONTENT ─── -->
                <div class="content-area">

                    <!-- Hero Banner -->
                    <div class="hero-banner" id="heroBanner">
                        <div class="hero-slides" id="heroSlides">
                            <div class="hero-slide hero-slide-1">
                                <div class="hero-content">
                                    <div class="hero-eyebrow">⚡ Limited Time Offer</div>
                                    <div class="hero-title">Mega Sale<br/>Up to 70% Off</div>
                                    <a href="#" class="hero-cta">Shop Now →</a>
                                </div>
                                <div class="hero-emoji">🛍️</div>
                            </div>
                            <div class="hero-slide hero-slide-2">
                                <div class="hero-content">
                                    <div class="hero-eyebrow">🔥 Flash Deals</div>
                                    <div class="hero-title">Tech Gadgets<br/>Best Prices</div>
                                    <a href="#" class="hero-cta">Explore →</a>
                                </div>
                                <div class="hero-emoji">📱</div>
                            </div>
                            <div class="hero-slide hero-slide-3">
                                <div class="hero-content">
                                    <div class="hero-eyebrow">🌿 New Arrivals</div>
                                    <div class="hero-title">Fresh Finds<br/>Near You</div>
                                    <a href="#" class="hero-cta">Discover →</a>
                                </div>
                                <div class="hero-emoji">✨</div>
                            </div>
                        </div>

                        <button class="hero-arrow hero-arrow-left" onclick="slideBanner(-1)">‹</button>
                        <button class="hero-arrow hero-arrow-right" onclick="slideBanner(1)">›</button>

                        <div class="hero-dots" id="heroDots">
                            <div class="hero-dot active" onclick="goSlide(0)"></div>
                            <div class="hero-dot" onclick="goSlide(1)"></div>
                            <div class="hero-dot" onclick="goSlide(2)"></div>
                        </div>
                    </div>

                    <!-- Flash Deals Bar -->
                    <div class="flash-bar">
                        <div class="flash-bar-label">⚡ Flash Deals
                            <div class="flash-timer">
                                <span class="timer-seg" id="timerH">02</span>
                                <span class="timer-colon">:</span>
                                <span class="timer-seg" id="timerM">47</span>
                                <span class="timer-colon">:</span>
                                <span class="timer-seg" id="timerS">31</span>
                            </div>
                        </div>
                        <a href="#" class="flash-see-all">See All →</a>
                    </div>

                    <!-- Flash Products -->
                    <div class="flash-grid">
                        <a href="#" class="flash-card">
                            <div class="flash-card-img">⌚</div>
                            <div class="flash-card-body">
                                <div class="flash-card-price">₱899</div>
                                <div class="flash-discount-bar"><div class="flash-discount-fill" style="width:82%"></div></div>
                                <div class="flash-sold-pct">82% sold</div>
                            </div>
                        </a>
                        <a href="#" class="flash-card">
                            <div class="flash-card-img">🎧</div>
                            <div class="flash-card-body">
                                <div class="flash-card-price">₱1,250</div>
                                <div class="flash-discount-bar"><div class="flash-discount-fill" style="width:65%"></div></div>
                                <div class="flash-sold-pct">65% sold</div>
                            </div>
                        </a>
                        <a href="#" class="flash-card">
                            <div class="flash-card-img">👟</div>
                            <div class="flash-card-body">
                                <div class="flash-card-price">₱599</div>
                                <div class="flash-discount-bar"><div class="flash-discount-fill" style="width:91%"></div></div>
                                <div class="flash-sold-pct">91% sold</div>
                            </div>
                        </a>
                        <a href="#" class="flash-card">
                            <div class="flash-card-img">💻</div>
                            <div class="flash-card-body">
                                <div class="flash-card-price">₱18,500</div>
                                <div class="flash-discount-bar"><div class="flash-discount-fill" style="width:44%"></div></div>
                                <div class="flash-sold-pct">44% sold</div>
                            </div>
                        </a>
                        <a href="#" class="flash-card">
                            <div class="flash-card-img">📷</div>
                            <div class="flash-card-body">
                                <div class="flash-card-price">₱3,200</div>
                                <div class="flash-discount-bar"><div class="flash-discount-fill" style="width:58%"></div></div>
                                <div class="flash-sold-pct">58% sold</div>
                            </div>
                        </a>
                        <a href="#" class="flash-card">
                            <div class="flash-card-img">🎮</div>
                            <div class="flash-card-body">
                                <div class="flash-card-price">₱2,499</div>
                                <div class="flash-discount-bar"><div class="flash-discount-fill" style="width:73%"></div></div>
                                <div class="flash-sold-pct">73% sold</div>
                            </div>
                        </a>
                    </div>

                    <!-- Sell CTA -->
                    <div class="sell-banner">
                        <div class="sell-banner-text">
                            <div class="sell-title">🏪 Got something to sell?</div>
                            <div class="sell-sub">List your items for free and reach thousands of local buyers.</div>
                        </div>
                        <asp:Button ID="bttnSell" runat="server" Text="+ Create Listing" CssClass="sell-btn" />
                    </div>

                    <!-- Today's Picks -->
                    <div class="section-header">
                        <div class="section-title">✨ Today's Picks</div>
                        <a href="#" class="section-see-all">See All →</a>
                    </div>
                    <div class="product-grid">
                        <a href="#" class="product-card" style="animation-delay:0.05s">
                            <div class="card-img-wrap">
                                🛋️
                                <span class="card-badge">-35%</span>
                                <div class="card-wish">🤍</div>
                            </div>
                            <div class="card-body">
                                <div class="card-name">Modern Minimalist Sofa 3-Seater</div>
                                <div class="card-price-row">
                                    <span class="card-price">₱12,500</span>
                                    <span class="card-price-old">₱19,200</span>
                                </div>
                                <div class="card-meta">
                                    <span class="card-rating"><span class="card-rating-star">★</span> 4.8</span>
                                    <span class="card-sold">234 sold</span>
                                </div>
                            </div>
                        </a>
                        <a href="#" class="product-card" style="animation-delay:0.10s">
                            <div class="card-img-wrap">
                                📱
                                <span class="card-badge new">NEW</span>
                                <div class="card-wish">🤍</div>
                            </div>
                            <div class="card-body">
                                <div class="card-name">Smartphone Pro Max 256GB</div>
                                <div class="card-price-row">
                                    <span class="card-price">₱24,999</span>
                                </div>
                                <div class="card-meta">
                                    <span class="card-rating"><span class="card-rating-star">★</span> 4.9</span>
                                    <span class="card-sold">1.2k sold</span>
                                </div>
                            </div>
                        </a>
                        <a href="#" class="product-card" style="animation-delay:0.15s">
                            <div class="card-img-wrap">
                                👗
                                <span class="card-badge">-50%</span>
                                <div class="card-wish">🤍</div>
                            </div>
                            <div class="card-body">
                                <div class="card-name">Summer Floral Dress Collection</div>
                                <div class="card-price-row">
                                    <span class="card-price">₱449</span>
                                    <span class="card-price-old">₱899</span>
                                </div>
                                <div class="card-meta">
                                    <span class="card-rating"><span class="card-rating-star">★</span> 4.7</span>
                                    <span class="card-sold">567 sold</span>
                                </div>
                            </div>
                        </a>
                        <a href="#" class="product-card" style="animation-delay:0.20s">
                            <div class="card-img-wrap">
                                🏋️
                                <div class="card-wish">🤍</div>
                            </div>
                            <div class="card-body">
                                <div class="card-name">Adjustable Dumbbell Set 20kg</div>
                                <div class="card-price-row">
                                    <span class="card-price">₱3,800</span>
                                    <span class="card-price-old">₱4,500</span>
                                </div>
                                <div class="card-meta">
                                    <span class="card-rating"><span class="card-rating-star">★</span> 4.6</span>
                                    <span class="card-sold">89 sold</span>
                                </div>
                            </div>
                        </a>
                        <a href="#" class="product-card" style="animation-delay:0.25s">
                            <div class="card-img-wrap">
                                🪴
                                <span class="card-badge new">NEW</span>
                                <div class="card-wish">🤍</div>
                            </div>
                            <div class="card-body">
                                <div class="card-name">Indoor Plant Bundle (5 pcs)</div>
                                <div class="card-price-row">
                                    <span class="card-price">₱799</span>
                                </div>
                                <div class="card-meta">
                                    <span class="card-rating"><span class="card-rating-star">★</span> 4.9</span>
                                    <span class="card-sold">312 sold</span>
                                </div>
                            </div>
                        </a>
                        <a href="#" class="product-card" style="animation-delay:0.30s">
                            <div class="card-img-wrap">
                                💄
                                <span class="card-badge">-20%</span>
                                <div class="card-wish">🤍</div>
                            </div>
                            <div class="card-body">
                                <div class="card-name">Skincare Essentials Set K-Beauty</div>
                                <div class="card-price-row">
                                    <span class="card-price">₱1,199</span>
                                    <span class="card-price-old">₱1,499</span>
                                </div>
                                <div class="card-meta">
                                    <span class="card-rating"><span class="card-rating-star">★</span> 4.8</span>
                                    <span class="card-sold">2.4k sold</span>
                                </div>
                            </div>
                        </a>
                        <a href="#" class="product-card" style="animation-delay:0.35s">
                            <div class="card-img-wrap">
                                🎒
                                <div class="card-wish">🤍</div>
                            </div>
                            <div class="card-body">
                                <div class="card-name">Waterproof Travel Backpack 40L</div>
                                <div class="card-price-row">
                                    <span class="card-price">₱1,650</span>
                                    <span class="card-price-old">₱2,200</span>
                                </div>
                                <div class="card-meta">
                                    <span class="card-rating"><span class="card-rating-star">★</span> 4.5</span>
                                    <span class="card-sold">178 sold</span>
                                </div>
                            </div>
                        </a>
                        <a href="#" class="product-card" style="animation-delay:0.40s">
                            <div class="card-img-wrap">
                                🖥️
                                <span class="card-badge">-15%</span>
                                <div class="card-wish">🤍</div>
                            </div>
                            <div class="card-body">
                                <div class="card-name">27" 4K IPS Gaming Monitor</div>
                                <div class="card-price-row">
                                    <span class="card-price">₱16,900</span>
                                    <span class="card-price-old">₱19,900</span>
                                </div>
                                <div class="card-meta">
                                    <span class="card-rating"><span class="card-rating-star">★</span> 4.7</span>
                                    <span class="card-sold">93 sold</span>
                                </div>
                            </div>
                        </a>
                    </div>

                    <!-- Nearby Listings -->
                    <div class="section-header">
                        <div class="section-title">📍 Near You in Cebu</div>
                        <a href="#" class="section-see-all">See All →</a>
                    </div>
                    <div class="nearby-grid">
                        <a href="#" class="nearby-card">
                            <div class="nearby-img">🚲</div>
                            <div class="nearby-body">
                                <div class="nearby-name">Mountain Bike 21-Speed</div>
                                <div class="nearby-price">₱5,500</div>
                                <div class="nearby-loc">📍 Cebu City · 0.8 km</div>
                            </div>
                        </a>
                        <a href="#" class="nearby-card">
                            <div class="nearby-img">🪑</div>
                            <div class="nearby-body">
                                <div class="nearby-name">Ergonomic Office Chair</div>
                                <div class="nearby-price">₱3,200</div>
                                <div class="nearby-loc">📍 Mandaue · 2.1 km</div>
                            </div>
                        </a>
                        <a href="#" class="nearby-card">
                            <div class="nearby-img">🐕</div>
                            <div class="nearby-body">
                                <div class="nearby-name">Shih Tzu Puppy 2 months</div>
                                <div class="nearby-price">₱8,000</div>
                                <div class="nearby-loc">📍 Lapu-Lapu · 3.5 km</div>
                            </div>
                        </a>
                        <a href="#" class="nearby-card">
                            <div class="nearby-img">📺</div>
                            <div class="nearby-body">
                                <div class="nearby-name">Samsung 55" Smart TV</div>
                                <div class="nearby-price">₱14,000</div>
                                <div class="nearby-loc">📍 Talisay · 5.0 km</div>
                            </div>
                        </a>
                    </div>

                </div><!-- /content-area -->
            </div><!-- /layout-grid -->
        </div><!-- /main-wrap -->

        <!-- ══════════════ BOTTOM NAV (mobile) ══════════════ -->
        <div class="bottom-nav">
            <div class="bottom-nav-inner">
                <a href="#" class="bottom-nav-item active">
                    <span class="bottom-nav-icon">🏠</span> Home
                </a>
                <a href="#" class="bottom-nav-item">
                    <span class="bottom-nav-icon">🔍</span> Search
                </a>
                <a href="#" class="bottom-nav-item">
                    <span class="bottom-nav-icon">➕</span> Sell
                </a>
                <a href="#" class="bottom-nav-item">
                    <span class="bottom-nav-icon">🛒</span> Cart
                </a>
                <a href="#" class="bottom-nav-item">
                    <span class="bottom-nav-icon">👤</span> Profile
                </a>
            </div>
        </div>

    </form>

    <script>
        /* ── Banner Slider ── */
        let currentSlide = 0;
        const totalSlides = 3;

        function goSlide(idx) {
            currentSlide = idx;
            document.getElementById('heroSlides').style.transform = `translateX(-${currentSlide * 100}%)`;
            document.querySelectorAll('.hero-dot').forEach((d, i) => {
                d.classList.toggle('active', i === currentSlide);
            });
        }

        function slideBanner(dir) {
            currentSlide = (currentSlide + dir + totalSlides) % totalSlides;
            goSlide(currentSlide);
        }

        // Auto-advance
        setInterval(() => slideBanner(1), 4500);

        /* ── Countdown Timer ── */
        let totalSeconds = 2 * 3600 + 47 * 60 + 31;

        function updateTimer() {
            if (totalSeconds <= 0) return;
            totalSeconds--;
            const h = Math.floor(totalSeconds / 3600);
            const m = Math.floor((totalSeconds % 3600) / 60);
            const s = totalSeconds % 60;
            document.getElementById('timerH').textContent = String(h).padStart(2, '0');
            document.getElementById('timerM').textContent = String(m).padStart(2, '0');
            document.getElementById('timerS').textContent = String(s).padStart(2, '0');
        }
        setInterval(updateTimer, 1000);

        /* ── Category chip active toggle ── */
        document.querySelectorAll('.cat-chip').forEach(chip => {
            chip.addEventListener('click', function (e) {
                e.preventDefault();
                document.querySelectorAll('.cat-chip').forEach(c => c.classList.remove('active'));
                this.classList.add('active');
            });
        });

        /* ── Sidebar link active toggle ── */
        document.querySelectorAll('.sidebar-link').forEach(link => {
            link.addEventListener('click', function (e) {
                e.preventDefault();
                document.querySelectorAll('.sidebar-link').forEach(l => l.classList.remove('active'));
                this.classList.add('active');
            });
        });

        /* ── Wishlist heart toggle ── */
        document.querySelectorAll('.card-wish').forEach(btn => {
            btn.addEventListener('click', function (e) {
                e.preventDefault();
                e.stopPropagation();
                this.textContent = this.textContent === '🤍' ? '❤️' : '🤍';
            });
        });
    </script>

</body>
</html>