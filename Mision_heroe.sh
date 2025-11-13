#!/bin/bash
# 🎮 Misión: Héroe del Reino
# Autor: Ely Quispe ✨
# Descripción: Juego "Piedra, Papel o Tijera" con historia y animaciones.

# --- FUNCIONES DE COLOR Y EFECTOS ---
verde="\e[32m"
rojo="\e[31m"
amarillo="\e[33m"
reset="\e[0m"

animar_texto() {
    texto="$1"
    for ((i=0; i<${#texto}; i++)); do
        echo -n "${texto:$i:1}"
        sleep 0.03
    done
    echo
}

# --- HISTORIA INICIAL ---
clear
animar_texto "🌟 Bienvenido, valiente héroe 🌟"
sleep 1
animar_texto "El Reino de Bashlandia está en peligro..."
sleep 1
animar_texto "Tres almas nobles necesitan tu ayuda para ser salvadas:"
sleep 1.5
echo
animar_texto "1️⃣ Reina Isabel 👑   — cautiva por Lord Tijeras ✂️"
animar_texto "2️⃣ Príncipe Papel 📜 — prisionero de Lady Piedra 🪨"
animar_texto "3️⃣ Maga Rocía 💫    — atrapada por Sir Aleatorio 🤖"
echo
sleep 1

misiones_ganadas=0

# --- FUNCIÓN DE ELECCIÓN DE JUGADA ---
opcion_juego() {
    echo
    echo "Elige tu jugada:"
    echo "1 -> 🪨 Piedra"
    echo "2 -> 🧻 Papel"
    echo "3 -> ✂️ Tijera"
    read -p "👉 " opcion
}

# --- FUNCIÓN DE ALEATORIO ---
numero_aleatorio() {
    numero=$(( (RANDOM % 3) + 1 ))
}

# --- FUNCIÓN PARA MOSTRAR RESULTADOS ---
traducirOpcion() {
    case $1 in
        1) echo "🪨 Piedra" ;;
        2) echo "🧻 Papel" ;;
        3) echo "✂️ Tijera" ;;
    esac
}

# --- FUNCIÓN DE BATALLA ---
batalla() {
    jugada=0
    gana_usuario=0
    gana_pc=0
    empates=0

    while [[ $jugada -lt 5 && $gana_pc -lt 3 && $gana_usuario -lt 5 ]]; do
        opcion_juego
        numero_aleatorio
        echo
        animar_texto "El enemigo está eligiendo..."
        sleep 1
        echo "Tú elegiste: $(traducirOpcion $opcion)"
        echo "El enemigo eligió: $(traducirOpcion $numero)"
        echo

        # Lógica de ganadores
        if [[ $opcion -eq $numero ]]; then
            let empates++
            if [[ $empates -eq 2 ]]; then
                echo -e "${rojo}Dos empates seguidos... pierdes esta ronda 😢${reset}"
                let gana_pc++
                empates=0
            else
                echo -e "${amarillo}Empate, se repite la ronda${reset}"
                continue
            fi
        else
            empates=0
            if [[ ($opcion -eq 1 && $numero -eq 3) || \
                  ($opcion -eq 2 && $numero -eq 1) || \
                  ($opcion -eq 3 && $numero -eq 2) ]]; then
                echo -e "${verde}¡Has ganado esta ronda!${reset}"
                let gana_usuario++
            else
                echo -e "${rojo}Has perdido esta ronda${reset}"
                let gana_pc++
            fi
        fi

        let jugada++
        echo "🧮 Rondas jugadas: $jugada | Tú: $gana_usuario | Enemigo: $gana_pc"
        echo
        sleep 1
    done

    # Resultado de la misión
    if [[ $gana_usuario -gt $gana_pc ]]; then
        echo -e "${verde}🎉 ¡Has ganado la misión!${reset}"
        let misiones_ganadas++
        echo -e "\a"  # Sonido de victoria
    else
        echo -e "${rojo}💀 Has fallado la misión...${reset}"
    fi
}

# --- MISIÓN: REINA ISABEL ---
mision_reina() {
    clear
    animar_texto "👑 Misión 1: Salvar a la Reina Isabel 👑"
    animar_texto "Tu rival es Lord Tijeras ✂️, maestro del filo y la rapidez..."
    sleep 1.5
    batalla
}

# --- MISIÓN: PRÍNCIPE PAPEL ---
mision_principe() {
    clear
    animar_texto "📜 Misión 2: Rescatar al Príncipe Papel 📜"
    animar_texto "Tu rival es Lady Piedra 🪨, fuerte e implacable."
    sleep 1.5
    batalla
}

# --- MISIÓN: MAGA ROCÍA ---
mision_maga() {
    clear
    animar_texto "💫 Misión 3: Liberar a la Maga Rocía 💫"
    animar_texto "Tu rival es Sir Aleatorio 🤖, señor del caos y la suerte."
    sleep 1.5
    batalla
}

# --- FINAL DORADO ---
final_dorado() {
    clear
    echo -e "${amarillo}"
    mensaje="🌟 ¡HAS SALVADO BASHLANDIA! 🌟"
    for ((i=0; i<${#mensaje}; i++)); do
        echo -n "${mensaje:$i:1}"
        sleep 0.05
    done
    echo -e "\n"
    sleep 1
    echo "El reino canta tu nombre en los valles y montañas..."
    sleep 1.5
    echo "Las constelaciones brillan formando tu símbolo en el cielo..."
    sleep 1.5
    echo "Gracias, valiente del reino, por restaurar la paz. 🌌"
    sleep 1.5
    echo -e "${reset}"
    echo -e "\a"
}

# --- MENÚ PRINCIPAL ---
while true; do
    clear
    animar_texto "✨ Elige tu misión, valiente del reino ✨"
    echo
    echo "1 -> Salvar a la Reina Isabel 👑"
    echo "2 -> Rescatar al Príncipe Papel 📜"
    echo "3 -> Liberar a la Maga Rocía 💫"
    echo "0 -> Salir"
    echo
    read -p "👉 " eleccion

    case $eleccion in
        1) mision_reina ;;
        2) mision_principe ;;
        3) mision_maga ;;
        0) clear; animar_texto "👋 Adiós, valiente. El reino te recordará."; exit ;;
        *) echo "Opción no válida"; sleep 1 ;;
    esac

    if [[ $misiones_ganadas -eq 3 ]]; then
        final_dorado
        exit
    fi

    read -p "Presiona Enter para continuar..."
done

