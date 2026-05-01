// ========== CALENDARIO CON DÍA ACTUAL MARCADO ==========
let currentDate = new Date(2026, 3); // Abril 2026

function generarCalendario() {
    const year = currentDate.getFullYear();
    const month = currentDate.getMonth();
    const firstDay = new Date(year, month, 1).getDay();
    let offset = firstDay === 0 ? 6 : firstDay - 1;
    const daysInMonth = new Date(year, month + 1, 0).getDate();
    const totalCells = 42;
    let html = "";
    const today = new Date();
    const todayYear = today.getFullYear();
    const todayMonth = today.getMonth();
    const todayDay = today.getDate();

    for (let i = 0; i < totalCells; i++) {
        let day = i - offset + 1;
        if (day >= 1 && day <= daysInMonth) {
            let cls = "";
            if (
                year === todayYear && month === todayMonth && day === todayDay
            ) {
                cls = 'class="today"';
            }
            html += `<span ${cls}>${day}</span>`;
        } else {
            html += `<span></span>`;
        }
    }
    document.getElementById("calendarDays").innerHTML = html;
    const meses = [
        "Enero",
        "Febrero",
        "Marzo",
        "Abril",
        "Mayo",
        "Junio",
        "Julio",
        "Agosto",
        "Septiembre",
        "Octubre",
        "Noviembre",
        "Diciembre",
    ];
    document.getElementById("monthYearDisplay").innerText = `${
        meses[month]
    } ${year}`;
}

function cambiarMes(delta) {
    currentDate.setMonth(currentDate.getMonth() + delta);
    generarCalendario();
}

document.getElementById("prevMonthBtn")?.addEventListener(
    "click",
    () => cambiarMes(-1),
);
document.getElementById("nextMonthBtn")?.addEventListener(
    "click",
    () => cambiarMes(1),
);

// ========== GRÁFICO ==========
const ctx = document.getElementById("weeklyProgress").getContext("2d");
new Chart(ctx, {
    type: "line",
    data: {
        labels: ["Lun", "Mar", "Mié", "Jue", "Vie", "Sáb", "Dom"],
        datasets: [{
            label: "Asistencias",
            data: [112, 135, 148, 127, 158, 92, 65],
            borderColor: "#dc2626",
            backgroundColor: "rgba(220,38,38,0.1)",
            fill: true,
            tension: 0.3,
        }],
    },
    options: {
        responsive: true,
        maintainAspectRatio: true,
        plugins: { legend: { labels: { color: "#1e293b" } } },
        scales: {
            y: { ticks: { color: "#1e293b" } },
            x: { ticks: { color: "#1e293b" } },
        },
    },
});

// ========== INICIALIZAR CALENDARIO ==========
generarCalendario();
