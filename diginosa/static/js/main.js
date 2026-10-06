/**
 * DigiNosa — Frontend JavaScript
 * Interaktivitas: scroll animations, gejala counter, category toggle, mobile menu
 */

document.addEventListener('DOMContentLoaded', () => {
    initScrollAnimations();
    initNavbar();
    initMobileMenu();
    initGejalaCounter();
    initCategoryToggle();
    initStatCounter();
});

/* --- Scroll Animations (Intersection Observer) --- */
function initScrollAnimations() {
    const observer = new IntersectionObserver((entries) => {
        entries.forEach(entry => {
            if (entry.isIntersecting) {
                entry.target.classList.add('visible');
            }
        });
    }, { threshold: 0.1, rootMargin: '0px 0px -40px 0px' });

    document.querySelectorAll('.animate-fade-up').forEach(el => observer.observe(el));
}

/* --- Navbar Scroll Effect --- */
function initNavbar() {
    const navbar = document.getElementById('navbar');
    if (!navbar) return;
    window.addEventListener('scroll', () => {
        navbar.classList.toggle('scrolled', window.scrollY > 50);
    });
}

/* --- Mobile Menu --- */
function initMobileMenu() {
    const btn = document.getElementById('mobileMenuBtn');
    const menu = document.getElementById('mobileMenu');
    if (!btn || !menu) return;
    btn.addEventListener('click', () => {
        menu.classList.toggle('open');
        btn.classList.toggle('active');
    });
}

/* --- Gejala Counter & Submit Button --- */
function initGejalaCounter() {
    const checkboxes = document.querySelectorAll('.gejala-checkbox');
    const countDisplay = document.getElementById('gejalaCount');
    const submitBtn = document.getElementById('submitBtn');
    const submitBtnBottom = document.getElementById('submitBtnBottom');
    if (!checkboxes.length || !countDisplay) return;

    function updateCount() {
        const checked = document.querySelectorAll('.gejala-checkbox:checked').length;
        countDisplay.textContent = checked;
        const disabled = checked === 0;
        if (submitBtn) submitBtn.disabled = disabled;
        if (submitBtnBottom) submitBtnBottom.disabled = disabled;
    }

    checkboxes.forEach(cb => cb.addEventListener('change', updateCount));

    // Reset button
    const resetBtn = document.getElementById('resetBtn');
    if (resetBtn) {
        resetBtn.addEventListener('click', (e) => {
            e.preventDefault();
            checkboxes.forEach(cb => cb.checked = false);
            updateCount();
        });
    }
}

/* --- Category Toggle (Expand/Collapse) --- */
function initCategoryToggle() {
    // Categories start open by default (class 'open' on kategori-body)
}

function toggleKategori(header) {
    const card = header.closest('.kategori-card');
    const body = card.querySelector('.kategori-body');
    if (!body) return;
    card.classList.toggle('collapsed');
    body.classList.toggle('open');
}

/* --- Stat Counter Animation --- */
function initStatCounter() {
    const statValues = document.querySelectorAll('.stat-value[data-count]');
    if (!statValues.length) return;

    const observer = new IntersectionObserver((entries) => {
        entries.forEach(entry => {
            if (entry.isIntersecting) {
                animateCounter(entry.target);
                observer.unobserve(entry.target);
            }
        });
    }, { threshold: 0.5 });

    statValues.forEach(el => observer.observe(el));
}

function animateCounter(el) {
    const target = parseInt(el.getAttribute('data-count'));
    const duration = 1500;
    const start = performance.now();

    function update(now) {
        const elapsed = now - start;
        const progress = Math.min(elapsed / duration, 1);
        // Ease out cubic
        const eased = 1 - Math.pow(1 - progress, 3);
        el.textContent = Math.round(target * eased);
        if (progress < 1) requestAnimationFrame(update);
    }

    requestAnimationFrame(update);
}