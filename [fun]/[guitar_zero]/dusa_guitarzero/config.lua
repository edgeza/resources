----------------------------------------------------------------
----                   DUSADEV.TEBEX.IO                     ----
----------------------------------------------------------------
Config = {}

--- @param -- Check https://lesimov.gitbook.io/dusa-docs for documentation

------------------------GENERAL OPTIONS------------------------
---------------------------------------------------------------
Config.Target = 'qtarget' -- false / ox_target / qb-target / qtarget
Config.StandItem = 'guitarstand'

-- COORDS
Config.Stands = {
    [1] = {
        coords = vector3(-1742.64, -1109.33, 13.017),
        heading = 232.4,
        blip = true
    },
}

Config.BlipOptions = { -- https://docs.fivem.net/docs/game-references/blips/
  sprite = 136,
  color = 61,
  scale = 0.7,
  name = "Guitar Zero"
}

-------------------------MUSIC LIST----------------------------
---------------------------------------------------------------

--[[	
	You can add new music to music list from here.

    name = "Music Name"
    path = "Music file name" -- format ___.mp3
    img = "imageurl"
    difficulty = "" -- easy, medium, hard
]]

Config.MusicList = {
    ["easy"] = {
        [1] = {
            name = '3\'s & 7\'s',
            path = 'stoneage.mp3',
            img = 'https://upload.wikimedia.org/wikipedia/en/thumb/e/ef/3%27s_%26_7%27s_%28Queens_of_the_Stone_Age_single_-_cover_art%29.jpg/220px-3%27s_%26_7%27s_%28Queens_of_the_Stone_Age_single_-_cover_art%29.jpg',
            difficulty = 'easy'
        },
        [2] = {
            name = 'Anarchy in the U.K',
            path = 'anarchy.mp3',
            img = 'https://upload.wikimedia.org/wikipedia/commons/thumb/8/8f/Anarchy_in_the_UK_by_Sex_Pistols_UK_single_side-A.png/220px-Anarchy_in_the_UK_by_Sex_Pistols_UK_single_side-A.png',
            difficulty = 'easy'
        },
        [3] = {
            name = 'Barracuda',
            path = 'hearth.mp3',
            img = 'https://upload.wikimedia.org/wikipedia/en/0/0a/Heart_-_Barracuda.png',
            difficulty = 'easy'
        },
        [4] = {
            name = 'Before I Forget',
            path = 'forget.mp3',
            img = 'https://upload.wikimedia.org/wikipedia/en/8/89/Before_I_Forget_cover1.gif',
            difficulty = 'easy'
        },
        [5] = {
            name = 'Black Magic Woman',
            path = 'magicwoman.mp3',
            img = 'https://upload.wikimedia.org/wikipedia/en/d/de/White_Zombie_Black_Sunshine_1.jpg',
            difficulty = 'easy'
        },
        [6] = {
            name = 'Black Sunshine',
            path = 'blacksunshine.mp3',
            img = 'https://upload.wikimedia.org/wikipedia/en/thumb/d/de/White_Zombie_Black_Sunshine_1.jpg/220px-White_Zombie_Black_Sunshine_1.jpg',
            difficulty = 'easy'
        },
        [7] = {
            name = 'Bulls on Parade',
            path = 'easy1.mp3',
            img = 'bullsonparadise.mp3',
            difficulty = 'easy'
        },
        [8] = {
            name = 'Cherub Rock',
            path = 'cherubrock.mp3',
            img = 'https://upload.wikimedia.org/wikipedia/en/0/0f/SmashingPumpkins-CherubRock.jpg',
            difficulty = 'easy'
        },
        [9] = {
            name = 'Cities on Flame with Rock and Roll',
            path = 'citiesflame.mp3',
            img = 'https://upload.wikimedia.org/wikipedia/en/thumb/0/0a/Cities_on_Flame_with_Rock_and_Roll.png/220px-Cities_on_Flame_with_Rock_and_Roll.png',
            difficulty = 'easy'
        },
        [10] = {
            name = 'Cult of Personality',
            path = 'personality.mp3',
            img = 'https://upload.wikimedia.org/wikipedia/en/9/97/Living_Colour_Cult_of_Personality.jpg',
            difficulty = 'easy'
        },
        [11] = {
            name = 'The Devil Went Down to Georgia',
            path = 'downtogeorgia.mp3',
            img = 'https://upload.wikimedia.org/wikipedia/en/6/62/The_Devil_Went_Down_To_Georgia_cover.jpg',
            difficulty = 'easy'
        },
        [12] = {
            name = 'Even Flow',
            path = 'evenflow.mp3',
            img = 'https://upload.wikimedia.org/wikipedia/en/thumb/6/6c/Evenflow.jpg/220px-Evenflow.jpg',
            difficulty = 'easy'
        },
        [13] = {
            name = 'Hit Me with Your Best Shot',
            path = 'hitwithme.mp3',
            img = 'https://upload.wikimedia.org/wikipedia/en/5/5b/Hit_Me_with_Your_Best_Shot_by_Pat_Benatar_US_vinyl.jpg',
            difficulty = 'easy'
        },
        [14] = {
            name = 'Holiday in Cambodia',
            path = 'cambodia.mp3',
            img = 'https://upload.wikimedia.org/wikipedia/en/5/53/Dead_Kennedys_-_Holiday_in_Cambodia_cover.jpg',
            difficulty = 'easy'
        },
        [15] = {
            name = 'Knights of Cydonia',
            path = 'cydonia.mp3',
            img = 'https://upload.wikimedia.org/wikipedia/en/thumb/6/68/MuseKnightsofcydonia.jpg/220px-MuseKnightsofcydonia.jpg',
            difficulty = 'easy'
        },
        [16] = {
            name = 'Kool Thing',
            path = 'koolthing.mp3',
            img = 'https://upload.wikimedia.org/wikipedia/en/thumb/8/87/Sykoolthing.jpg/220px-Sykoolthing.jpg',
            difficulty = 'easy'
        },
        [17] = {
            name = 'La Grange',
            path = 'lagrange.mp3',
            img = 'https://upload.wikimedia.org/wikipedia/en/0/0f/ZZ_LaGrange_Single.jpg',
            difficulty = 'easy'
        },
    },
    ["medium"] = {
        [1] = {
            name = 'Sabotage',
            path = 'sabotage.mp3',
            img = 'https://upload.wikimedia.org/wikipedia/en/e/e5/Sabotage_single.jpg',
            difficulty = 'medium'
        },
        [2] = {
            name = 'Never Fade Away',
            path = 'neverfadeaway.mp3',
            img = 'https://static.wikia.nocookie.net/cyberpunk/images/7/78/SamuraiNeverFadeAwayCover.jpg/revision/latest?cb=20210306160628',
            difficulty = 'medium'
        },
        [3] = {
            name = 'We Could Be The Same',
            path = 'bethesame.mp3',
            img = 'https://upload.wikimedia.org/wikipedia/tr/thumb/c/c3/We_Could_Be_The_Same.jpg/250px-We_Could_Be_The_Same.jpg',
            difficulty = 'medium'
        },
        [4] = {
            name = 'Somewhere Only We Know',
            path = 'weknow.mp3',
            img = 'https://upload.wikimedia.org/wikipedia/en/thumb/e/e9/Keane-SOWK.jpg/220px-Keane-SOWK.jpg',
            difficulty = 'medium'
        },
        [5] = {
            name = 'Mississippi Queen',
            path = 'missisipi.mp3',
            img = 'https://upload.wikimedia.org/wikipedia/en/7/76/MississippiQueen45.jpg',
            difficulty = 'medium'
        },
        [6] = {
            name = 'Voices',
            path = 'voices.mp3',
            img = 'https://upload.wikimedia.org/wikipedia/en/d/d5/Voices_%28Matchbook_Romance_album%29.jpg',
            difficulty = 'medium'
        },
        [7] = {
            name = 'The Number of the Beast',
            path = 'thenumber.mp3',
            img = 'https://upload.wikimedia.org/wikipedia/en/8/85/The_Number_of_the_Beast_%28Iron_Maiden_single_-_cover_art%29.jpg',
            difficulty = 'medium'
        },
        [8] = {
            name = 'One',
            path = 'one.mp3',
            img = 'https://upload.wikimedia.org/wikipedia/en/f/fb/Metallica_-_One_cover.jpg',
            difficulty = 'medium'
        },
        [9] = {
            name = 'Paint It Black',
            path = 'paint.mp3',
            img = 'https://upload.wikimedia.org/wikipedia/en/thumb/5/58/Paint_It_Black_UK_sleeve.jpg/220px-Paint_It_Black_UK_sleeve.jpg',
            difficulty = 'medium'
        },
        [10] = {
            name = 'Paranoid',
            path = 'paranoid.mp3',
            img = 'https://upload.wikimedia.org/wikipedia/en/e/e1/Paranoid-The_Wizard_1970_7.jpg',
            difficulty = 'medium'
        },
        [11] = {
            name = 'Pride and Joy',
            path = 'pride.mp3',
            img = 'https://upload.wikimedia.org/wikipedia/en/thumb/b/b1/Pride_and_Joy_%28Stevie_Ray_Vaughan_song%29.png/220px-Pride_and_Joy_%28Stevie_Ray_Vaughan_song%29.png',
            difficulty = 'medium'
        },
        [12] = {
            name = 'Reptilia',
            path = 'reptilia.mp3',
            img = 'https://upload.wikimedia.org/wikipedia/en/8/81/The_Strokes_-_Reptilia_-_CD_single_cover.jpg',
            difficulty = 'medium'
        },
        [13] = {
            name = 'Rock and Roll All Nite',
            path = 'rockandrollnite.mp3',
            img = 'https://upload.wikimedia.org/wikipedia/en/e/e6/RARAN_Single.jpg',
            difficulty = 'medium'
        },
        [14] = {
            name = 'Rock You Like a Hurricane',
            path = 'rockahurricane.mp3',
            img = 'https://upload.wikimedia.org/wikipedia/en/2/29/Rock_You_Like_a_Hurricane_by_Scorpions_European_artwork_German_release.png',
            difficulty = 'medium'
        },
    },
    ["hard"] = {
        [1] = {
            name = 'Welcome to the Jungle',
            path = 'jungle.mp3',
            img = 'https://upload.wikimedia.org/wikipedia/en/d/d6/Welcometothejungle.jpg',
            difficulty = 'hard'
        },
        [2] = {
            name = 'Master of Puppets',
            path = 'puppets.mp3',
            img = 'https://upload.wikimedia.org/wikipedia/en/thumb/b/b2/Metallica_-_Master_of_Puppets_cover.jpg/220px-Metallica_-_Master_of_Puppets_cover.jpg',
            difficulty = 'hard'
        },
        [3] = {
            name = 'Belly Dancing',
            path = 'belly.mp3',
            img = 'https://media.discordapp.net/attachments/1143528082913906688/1184610942705737828/image.png?ex=658c99e9&is=657a24e9&hm=e50b0e218e015a34208f3fbefb096130bfb90546db5662955cc92b0d0f9c0143&=&format=webp&quality=lossless',
            difficulty = 'hard'
        },
        [4] = {
            name = 'Mockingbird',
            path = 'mockingbird.mp3',
            img = 'https://upload.wikimedia.org/wikipedia/en/thumb/f/fc/Mockingbird_%28Eminem_song%29_cover.jpg/220px-Mockingbird_%28Eminem_song%29_cover.jpg',
            difficulty = 'hard'
        },
        [5] = {
            name = 'Godzilla',
            path = 'godzilla.mp3',
            img = 'https://t2.genius.com/unsafe/340x340/https%3A%2F%2Fimages.genius.com%2F828acd1e1136e2e79248620d4ff2be4d.600x600x1.png',
            difficulty = 'hard'
        },
        [6] = {
            name = 'I Was Made for Lovin\' You',
            path = 'lovinyou.mp3',
            img = 'https://upload.wikimedia.org/wikipedia/en/2/28/KISSIWasMadeForLovinYouFrench7InchSingleCover.jpg',
            difficulty = 'hard'
        },
        [7] = {
            name = 'Chosen',
            path = 'chosen.mp3',
            img = 'https://cdn.discordapp.com/attachments/1143528082913906688/1184613919944355940/image.png?ex=658c9caf&is=657a27af&hm=47d9b5b6381d2a3357002a20b172948cb6871db483e98cc540d356b9e78f8366&',
            difficulty = 'hard'
        },
        [8] = {
            name = 'La Isla Bonita',
            path = 'bonita.mp3',
            img = 'https://upload.wikimedia.org/wikipedia/tr/a/aa/La_Isla_Bonita_single_cover.jpg',
            difficulty = 'hard'
        },
        [9] = {
            name = 'Beggin',
            path = 'beggin.mp3',
            img = 'https://cdn.discordapp.com/attachments/1143528082913906688/1184613919944355940/image.png?ex=658c9caf&is=657a27af&hm=47d9b5b6381d2a3357002a20b172948cb6871db483e98cc540d356b9e78f8366&',
            difficulty = 'hard'
        },
    },
}

-------------------------TRANSLATIONS--------------------------
---------------------------------------------------------------
Config.Locale = "en" -- en / de / fr / es / it / tr
Config.Translations = {
    ["en"] = {
        selectmusic = "Select a music",
        easy = "Easy",
        medium = "Medium",
        hard = "Hard",
        select = "Select",
        play = "Play",
        back = "Back",
        groupList = "Group List",
        soloList = "Solo List",
        scoreBoard = "Score Board",
        groupManagement = "Group Management",
        seeAllGroup = "Show All Groups",
        createaGroup = "Create a Group",
        myGroup = "My Groups",
        members = "Members",
        join = "Join",
        full = "Full",
        groupname = "Group Name",
        textagroupname = "Text a Group Name",
        addMember = "Add Member",
        createGroup = "Create Group",
        leaveGroup = "Leave Group",
        playwithGroup = "Play with group",
        deleteGroup = "Delete Group",
        areyousure = "Are you sure?",
        accept = "Accept",
        decline = "Decline",

        -- Notification
        error = "Error",
        success = "Success",
        info = "Info",
        quest = "Quest",
        beclose = "You need to be close a stand to play Guitar Zero",
        personalscore = "Game has ended, Your personal score is ",
        newgrouprecord = "New Record! New group record score is ",
        personalrecord = "NEW RECORD! Your new score is ",
        leaderisnotactive = "Leader is not active for this group",
        groupcreated = "Group created successfully",
        cantempty = "Group name can't be empty",
        joinaccept = "Group joined accept (Y) or decline (N)",
        cantjoin = "You cant join your group!",

        -- Target
        playnow = "Play Now",
        groups = "Groups",
        tscoreboard = "Score Board",
    },
    ["de"] = {
        selectmusic = "Musik auswählen",
        easy = "Leicht",
        medium = "Mittel",
        hard = "Schwer",
        select = "Auswählen",
        play = "Spielen",
        back = "Zurück",
        groupList = "Gruppenliste",
        soloList = "Solo-Liste",
        scoreBoard = "Punktestand",
        groupManagement = "Gruppenverwaltung",
        seeAllGroup = "Alle Gruppen anzeigen",
        createaGroup = "Gruppe erstellen",
        myGroup = "Meine Gruppen",
        members = "Mitglieder",
        join = "Beitreten",
        full = "Voll",
        groupname = "Gruppenname",
        textagroupname = "Texte einen Gruppennamen",
        addMember = "Mitglied hinzufügen",
        createGroup = "Gruppe erstellen",
        leaveGroup = "Gruppe verlassen",
        playwithGroup = "Mit Gruppe spielen",
        deleteGroup = "Gruppe löschen",
        areyousure = "Bist du sicher?",
        accept = "Akzeptieren",
        decline = "Ablehnen",
    
        -- Bildirimler
        error = "Fehler",
        success = "Erfolg",
        info = "Info",
        quest = "Aufgabe",
        beclose = "Du musst dich in der Nähe eines Stands befinden, um Guitar Zero zu spielen",
        personalscore = "Das Spiel ist zu Ende, dein persönlicher Punktestand ist ",
        newgrouprecord = "Neuer Rekord! Der neue Gruppenrekord beträgt ",
        personalrecord = "NEUER REKORD! Dein neuer Punktestand ist ",
        leaderisnotactive = "Der Gruppenleiter ist für diese Gruppe nicht aktiv",
        groupcreated = "Gruppe erfolgreich erstellt",
        cantempty = "Gruppenname kann nicht leer sein",
        joinaccept = "Gruppenbeitritt annehmen (Y) oder ablehnen (N)",
        cantjoin = "Du kannst nicht deiner Gruppe beitreten!",
    
        -- Ziel
        playnow = "Jetzt spielen",
        groups = "Gruppen",
        tscoreboard = "Punktestand",
    },
    ["it"] = {
        selectmusic = "Seleziona una musica",
        easy = "Facile",
        medium = "Medio",
        hard = "Difficile",
        select = "Seleziona",
        play = "Gioca",
        back = "Indietro",
        groupList = "Lista dei gruppi",
        soloList = "Lista dei solisti",
        scoreBoard = "Tabellone dei punteggi",
        groupManagement = "Gestione del gruppo",
        seeAllGroup = "Mostra tutti i gruppi",
        createaGroup = "Crea un gruppo",
        myGroup = "I miei gruppi",
        members = "Membri",
        join = "Unisciti",
        full = "Pieno",
        groupname = "Nome del gruppo",
        textagroupname = "Inserisci un nome per il gruppo",
        addMember = "Aggiungi membro",
        createGroup = "Crea gruppo",
        leaveGroup = "Abbandona gruppo",
        playwithGroup = "Gioca con il gruppo",
        deleteGroup = "Elimina gruppo",
        areyousure = "Sei sicuro?",
        accept = "Accetta",
        decline = "Rifiuta",
    
        -- Notifiche
        error = "Errore",
        success = "Successo",
        info = "Informazione",
        quest = "Missione",
        beclose = "Devi essere vicino a uno stand per giocare a Guitar Zero",
        personalscore = "Il gioco è finito, il tuo punteggio personale è ",
        newgrouprecord = "Nuovo record! Il nuovo punteggio record del gruppo è ",
        personalrecord = "NUOVO RECORD! Il tuo nuovo punteggio è ",
        leaderisnotactive = "Il capogruppo non è attivo per questo gruppo",
        groupcreated = "Gruppo creato con successo",
        cantempty = "Il nome del gruppo non può essere vuoto",
        joinaccept = "Unisciti al gruppo accettare (Y) o rifiutare (N)",
        cantjoin = "Non puoi unirti al tuo gruppo!",
    
        -- Obiettivi
        playnow = "Gioca ora",
        groups = "Gruppi",
        tscoreboard = "Tabellone dei punteggi",
    },
    ["fr"] = {
        selectmusic = "Sélectionner une musique",
        easy = "Facile",
        medium = "Moyen",
        hard = "Difficile",
        select = "Sélectionner",
        play = "Jouer",
        back = "Retour",
        groupList = "Liste des groupes",
        soloList = "Liste des solos",
        scoreBoard = "Tableau des scores",
        groupManagement = "Gestion du groupe",
        seeAllGroup = "Afficher tous les groupes",
        createaGroup = "Créer un groupe",
        myGroup = "Mes groupes",
        members = "Membres",
        join = "Rejoindre",
        full = "Complet",
        groupname = "Nom du groupe",
        textagroupname = "Entrez un nom de groupe",
        addMember = "Ajouter un membre",
        createGroup = "Créer un groupe",
        leaveGroup = "Quitter le groupe",
        playwithGroup = "Jouer avec le groupe",
        deleteGroup = "Supprimer le groupe",
        areyousure = "Êtes-vous sûr ?",
        accept = "Accepter",
        decline = "Refuser",
    
        -- Notifications
        error = "Erreur",
        success = "Succès",
        info = "Info",
        quest = "Quête",
        beclose = "Vous devez être près d'un stand pour jouer à Guitar Zero",
        personalscore = "La partie est terminée, votre score personnel est de ",
        newgrouprecord = "Nouveau record ! Le nouveau score record du groupe est de ",
        personalrecord = "NOUVEAU RECORD ! Votre nouveau score est de ",
        leaderisnotactive = "Le leader n'est pas actif pour ce groupe",
        groupcreated = "Groupe créé avec succès",
        cantempty = "Le nom du groupe ne peut pas être vide",
        joinaccept = "Rejoindre le groupe accepter (Y) ou refuser (N)",
        cantjoin = "Tu ne peux pas rejoindre ton groupe !",
    
        -- Cibles
        playnow = "Jouer maintenant",
        groups = "Groupes",
        tscoreboard = "Tableau des scores",
    },
    ["es"] = {
        selectmusic = "Seleccionar una música",
        easy = "Fácil",
        medium = "Intermedio",
        hard = "Difícil",
        select = "Seleccionar",
        play = "Jugar",
        back = "Volver",
        groupList = "Lista de grupos",
        soloList = "Lista de solos",
        scoreBoard = "Tabla de puntuaciones",
        groupManagement = "Gestión de grupo",
        seeAllGroup = "Mostrar todos los grupos",
        createaGroup = "Crear un grupo",
        myGroup = "Mis grupos",
        members = "Miembros",
        join = "Unirse",
        full = "Lleno",
        groupname = "Nombre del grupo",
        textagroupname = "Escribe un nombre de grupo",
        addMember = "Agregar miembro",
        createGroup = "Crear grupo",
        leaveGroup = "Salir del grupo",
        playwithGroup = "Jugar con el grupo",
        deleteGroup = "Eliminar grupo",
        areyousure = "¿Estás seguro?",
        accept = "Aceptar",
        decline = "Rechazar",
    
        -- Notificaciones
        error = "Error",
        success = "Éxito",
        info = "Información",
        quest = "Misión",
        beclose = "Debes estar cerca de un puesto para jugar a Guitar Zero",
        personalscore = "El juego ha terminado, tu puntuación personal es ",
        newgrouprecord = "¡Nuevo récord! El nuevo récord del grupo es ",
        personalrecord = "¡NUEVO RÉCORD! Tu nueva puntuación es ",
        leaderisnotactive = "El líder no está activo para este grupo",
        groupcreated = "Grupo creado exitosamente",
        cantempty = "El nombre del grupo no puede estar vacío",
        joinaccept = "Unirse al grupo aceptar (Y) o declinar (N)",
        cantjoin = "¡No puedes unirte a tu grupo!",
    
        -- Objetivos
        playnow = "Jugar ahora",
        groups = "Grupos",
        tscoreboard = "Tabla de puntuaciones",
    },
    ["tr"] = {
        selectmusic = "Müzik Seç",
        easy = "Kolay",
        medium = "Orta",
        hard = "Zor",
        select = "Seç",
        play = "Oyna",
        back = "Geri",
        groupList = "Grup Listesi",
        soloList = "Solo Listesi",
        scoreBoard = "Puan Tablosu",
        groupManagement = "Grup Yönetimi",
        seeAllGroup = "Tüm Grupları Göster",
        createaGroup = "Grup Oluştur",
        myGroup = "Benim Gruplarım",
        members = "Üyeler",
        join = "Katıl",
        full = "Dolu",
        groupname = "Grup Adı",
        textagroupname = "Bir Grup Adı Yaz",
        addMember = "Üye Ekle",
        createGroup = "Grup Oluştur",
        leaveGroup = "Gruptan Ayrıl",
        playwithGroup = "Grupla Oyna",
        deleteGroup = "Grubu Sil",
        areyousure = "Emin misiniz?",
        accept = "Kabul Et",
        decline = "Reddet",
    
        -- Bildirimler
        error = "Hata",
        success = "Başarı",
        info = "Bilgi",
        quest = "Görev",
        beclose = "Guitar Zero oynamak için bir standa yakın olmalısınız",
        personalscore = "Oyun bitti, kişisel puanınız ",
        newgrouprecord = "Yeni Rekor! Yeni grup rekoru ",
        personalrecord = "YENİ REKOR! Yeni puanınız ",
        leaderisnotactive = "Grup lideri bu grup için aktif değil",
        groupcreated = "Grup başarıyla oluşturuldu",
        cantempty = "Grup adı boş olamaz",
        joinaccept = "Gruba katılımı kabul et (Y) veya reddet (N)",
        cantjoin = "Kendi grubuna katılamazsın!",
    
        -- Hedefler
        playnow = "Şimdi Oyna",
        groups = "Gruplar",
        tscoreboard = "Puan Tablosu",
    },
                    
}