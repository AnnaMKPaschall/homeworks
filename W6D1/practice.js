document.addEventListener("DOMContentLoaded", function(){
    const canvas = document.getElementById("mycanvas"); 
    canvas.height = 500; 
    canvas.width = 500; 
    const ctx = canvas.getContext("2d"); 

    ctx.fillStyle = "red"; 
    ctx.fillRect(0, 0, canvas.height, canvas.width); 

    ctx.beginPath();
    ctx.arc(100, 75, 50, 0, 2*Math.PI, true); 
    ctx.strokeStyle = "purple"; 
    ctx.lineWidth = 10; 
    ctx.stroke(); 

    ctx.beginPath();
    ctx.strokeStyle = "blue";
    ctx.moveTo(750, 50);
    ctx.lineTo(100, 75);
    ctx.lineTo(100, 25);
    ctx.fill();




});
