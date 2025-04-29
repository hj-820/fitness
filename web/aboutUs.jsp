<%-- 
    Document   : aboutUs
    Created on : 28 Apr 2025, 16:36:48
    Author     : Hong Jie
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ include file="headerHome.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>About Us - Fitness Concept</title>
    <style>
        /* About Us Styles */
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
        }
        .about-header {
            text-align: center;
            padding: 60px 20px 20px;
            background-color: #f7f7f7;
        }
        .about-header h1 {
            font-size: 48px;
            margin-bottom: 20px;
            color: #333;
        }
        .about-image img {
            width: 100%;
            height: auto;
            display: block;
            margin-bottom: 40px;
        }
        .about-content {
            max-width: 1000px;
            margin: 0 auto;
            padding: 20px;
            line-height: 1.8;
            color: #555;
            text-align: justify;
        }
        .categories-overview {
            background-color: #fafafa;
            padding: 50px 20px;
            text-align: center;
        }
        .categories-overview h2 {
            margin-bottom: 30px;
            font-size: 36px;
            color: #333;
        }
        .categories-list {
            display: flex;
            justify-content: center;
            flex-wrap: wrap;
            gap: 30px;
        }
        .category-item {
            background: #fff;
            border: 1px solid #ddd;
            border-radius: 10px;
            padding: 20px 30px;
            width: 220px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.05);
            transition: transform 0.3s;
        }
        .category-item:hover {
            transform: translateY(-5px);
        }
        .category-item h3 {
            margin-bottom: 10px;
            color: #ff4081;
            font-size: 24px;
        }
        .category-item p {
            font-size: 14px;
            color: #666;
        }
    </style>
</head>

<body>

<div class="about-header">
    <h1>About Us</h1>
</div>

<div class="about-image">
    <img src="https://benchfitness.com/cdn/shop/files/homepage_head_cover.png?v=1725337917&width=3840" alt="Fitness Concept">
</div>

<div class="about-content">
    <p>
        Fitness Concept is the leading health and fitness equipment chain store that caters to the development of a healthy lifestyle for every Malaysian.
        <br><br>
        As a proud member of the Transmark Group of Companies with over 40 years of industry expertise, Fitness Concept has expanded steadily to over 45 retail outlets nationwide. We are certified by the Malaysia Book of Records as the "Largest Fitness Specialist Chain Store".
        <br><br>
        Our dedication to excellence has been recognized with prestigious awards such as the BrandLaureate SMEs Chapter award for Best Brand in Health & Fitness Equipment, the Golden Bull Award for Outstanding SMEs, and "Retailer of the Year 2018/2019" by the Malaysia Retailers Association (MRA). Internationally, we were honored as the Country Winner for "Customer Service Excellence" by the Federation of Asia Pacific Retailers Association (FAPRA). We also proudly clinched the Gold in the Asia eCommerce Awards 2021 and Silver at the 2022 Markies Awards.
        <br><br>
        <strong>Our Products</strong><br>
        We offer an extensive range of health and fitness equipment sourced from the USA, Europe, and Asia Pacific. We are the authorized distributor for world-renowned brands including NordicTrack, Sole Fitness, Reebok, ProForm, Cybex, Bodysolid, Adidas, Nautilus, Schwinn, Inspire, ForceUSA, LifeFitness, Marcy, Garmin, and many more.
        <br><br>
        Our products include innovative treadmills, exercise bikes, strength training systems, fitness accessories, and more — helping you achieve a healthier lifestyle.
    </p>
</div>

<!-- Categories Overview -->
<div class="categories-overview">
    <h2>Our Categories</h2>
    <div class="categories-list">
        <div class="category-item">
            <h3>Cardio</h3>
            <p>Ellipticals, Bikes, and Fitness Machines for Heart Health.</p>
        </div>
        <div class="category-item">
            <h3>Strength</h3>
            <p>Weight Benches, Dumbbells, Plates, and Multi-Station Gyms.</p>
        </div>
        <div class="category-item">
            <h3>Accessories</h3>
            <p>Gym Balls, Resistance Bands, Mats, and Rehabilitation Tools.</p>
        </div>
        <div class="category-item">
            <h3>Treadmill</h3>
            <p>Premium Running Machines for Home and Commercial Use.</p>
        </div>
    </div>
</div>

<%@ include file="footer.jsp" %>
</body>
</html>
