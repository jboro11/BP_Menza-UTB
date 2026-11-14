/**
 * Jednoduchý klientský směrovač pro offline dokumentaci.
 * Zajišťuje plynulé přechody mezi kapitolami bez blikání.
 */
document.addEventListener('DOMContentLoaded', () => {
    // DETEKCE PROTOKOLU file:// (otevření přímo z disku poklepáním v průzkumníku)
    // Moderní prohlížeče z bezpečnostních důvodů blokují AJAX (fetch) a pushState 
    // u lokálních souborů. Pokud běžíme na disku, vypneme SPA směrování a necháme
    // prohlížeč navigovat standardní cestou (klasické klikání na HTML soubory).
    if (window.location.protocol === 'file:') {
        console.log('Menza UTB Nápověda: Spuštěno z disku přes file://. Aktivován klasický HTML režim.');
        return;
    }

    // Navázání událostí na kliknutí na odkazy
    document.body.addEventListener('click', async (e) => {
        const link = e.target.closest('a');
        if (!link) return;

        const url = link.getAttribute('href');
        
        // Ignorujeme externí odkazy, kotvy nebo stahování
        if (!url || url.startsWith('http') || url.startsWith('#') || link.target === '_blank') {
            return;
        }

        e.preventDefault();
        
        // Získání cílové cesty
        const a = document.createElement('a');
        a.href = url;
        const targetPath = a.pathname + a.search;

        if (targetPath === window.location.pathname + window.location.search) return;

        // Uložení stavu do historie prohlížeče
        window.history.pushState({ path: targetPath }, '', url);
        await loadContent(targetPath);
    });

    // Podpora pro tlačítka Zpět/Vpřed v prohlížeči
    window.addEventListener('popstate', async (e) => {
        const path = e.state?.path || window.location.pathname + window.location.search;
        await loadContent(path, false);
    });

    // Výchozí uložení stavu
    window.history.replaceState({ path: window.location.pathname + window.location.search }, document.title, window.location.href);
});

// Mobilní menu toggle delegace (tlačítko na mobilech)
document.addEventListener('click', e => {
    const btn = e.target.closest('#menu-toggle');
    if (btn) {
        const menu = document.getElementById('menu');
        if (menu) menu.classList.toggle('open');
    }
});

// Asynchronní načtení obsahu jiné stránky přes AJAX
async function loadContent(url, scrollToTop = true) {
    const xmain = document.getElementById('xmain');
    if (!xmain) {
        window.location.href = url;
        return;
    }

    // Nastavení rychlého a moderního přechodu
    xmain.style.transition = 'opacity 0.12s ease-in-out';
    
    // Spuštění stahování na pozadí souběžně s animací
    const fetchPromise = fetch(url).then(async (response) => {
        if (!response.ok) throw new Error('Nepodařilo se načíst stránku: ' + response.status);
        return response.text();
    });

    // Čekání na dokončení stmívací fáze (120 ms)
    const fadeOutPromise = new Promise((resolve) => {
        xmain.style.opacity = '0';
        setTimeout(resolve, 120);
    });

    try {
        // Počkáme, až se stáhnou data a zároveň skončí ztlumení obrazovky
        const [html] = await Promise.all([fetchPromise, fadeOutPromise]);
        
        // Parsování nového obsahu
        const parser = new DOMParser();
        const doc = parser.parseFromString(html, 'text/html');
        
        // Výměna obsahu hlavního kontejneru a titulku
        const newXmain = doc.getElementById('xmain');
        if (newXmain) {
            xmain.innerHTML = newXmain.innerHTML;
            document.title = doc.title;
            if (scrollToTop) window.scrollTo(0, 0);
        }
        
        // Vynucení reflow pro hladký přechod rozsvícení
        xmain.offsetHeight; 
        
        // Rozsvícení nového obsahu
        xmain.style.opacity = '1';
    } catch (err) {
        console.warn('Směrovač selhal, přecházím na klasické načtení:', err);
        window.location.href = url;
    }
}
