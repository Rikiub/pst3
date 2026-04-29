// ========== TOGGLE SIDEBAR ==========
const sidebar = document.getElementById("sidebar");
const toggleBtn = document.getElementById("sidebarToggle");
if (sidebar && toggleBtn) {
    toggleBtn.addEventListener("click", () => {
        sidebar.classList.toggle("collapsed");
        localStorage.setItem(
            "sidebarCollapsed",
            sidebar.classList.contains("collapsed"),
        );
    });
    if (localStorage.getItem("sidebarCollapsed") === "true") {
        sidebar.classList.add("collapsed");
    }
}

// ========== DROPDOWNS ==========
// Reporte
const reporteTrigger = document.getElementById("reporteTrigger");
const reporteMenu = document.getElementById("reporteMenu");
if (reporteTrigger && reporteMenu) {
    reporteTrigger.addEventListener("click", (e) => {
        e.preventDefault();
        e.stopPropagation();
        reporteMenu.classList.toggle("show");
    });
    document.addEventListener("click", (e) => {
        if (
            !reporteTrigger.contains(e.target) &&
            !reporteMenu.contains(e.target)
        ) {
            reporteMenu.classList.remove("show");
        }
    });
    reporteMenu.querySelectorAll("a").forEach((item) => {
        item.addEventListener("click", (e) => {
            e.preventDefault();
            const tipo = item.getAttribute("data-reporte") || "personalizado";
            alert(`Generando reporte ${tipo}... (simulación)`);
            reporteMenu.classList.remove("show");
        });
    });
}
// Perfil
const profileIcon = document.getElementById("profileIcon");
const profileMenu = document.getElementById("profileMenu");
if (profileIcon && profileMenu) {
    profileIcon.addEventListener("click", (e) => {
        e.stopPropagation();
        profileMenu.classList.toggle("show");
    });
    document.addEventListener("click", (e) => {
        if (
            !profileIcon.contains(e.target) && !profileMenu.contains(e.target)
        ) {
            profileMenu.classList.remove("show");
        }
    });
}

// ========== ACORDEÓN MENÚ ==========
document.querySelectorAll(".group-title").forEach((title) => {
    title.addEventListener("click", (e) => {
        e.stopPropagation();
        const groupId = title.getAttribute("data-group");
        const items = document.getElementById(groupId);
        if (items) {
            const isVisible = items.style.display === "flex";
            items.style.display = isVisible ? "none" : "flex";
            const icon = title.querySelector(".toggle-icon");
            if (icon) {
                icon.style.transform = isVisible
                    ? "rotate(0deg)"
                    : "rotate(180deg)";
            }
        }
    });
});
