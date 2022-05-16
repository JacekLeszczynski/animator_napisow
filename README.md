# animator_napisow
Stwórz fragment filmu z poruszającymi się napisami z dołu do góry

Działa to tak, wklejasz tekst który ma być wyświetlany na filmie,
ustalasz parametry tej animacji, początkową i końcową pausę,
i poprawkę na długość animacji.

Ta poprawka jest potrzebna, bo nie do końca wiem jak wyliczyć
to w programie, nalezy to robić metodą prób i błędów.

No i ustawić prędkośc animacji, do wyliczenia poprawki można ustawić
ta wartość na najniższą, by napisy przelatywały szybko. A gdy już to
mamy, ustawić wartość pożądaną i woila!

Na końcu włączamy ciapka OBS, uruchamiamy w tle OBS-a i program z automatu
uruchomi animację, rozpocznie zapis do filmu i zakończy go po skończeniu animacji.
Póki co dane do komunikacji z OBS-em, tj. port, hasło należy ustawić w kodzie,
jasna sprawa, że i OBS-a należy skonfigurować w odpowiedni sposób,
dograć odpowiednią wtyczkę do komunikacji z konsoli itd.
