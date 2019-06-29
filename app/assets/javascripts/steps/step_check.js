function checkMissionAttributes() {
    if ($('#mission_who_am_i').val() ||
        $('#mission_why_exist').val() ||
        $('#mission_purpose_of_life').val()) {
        if(confirm("Você deseja prosseguir sem salvar sua missão?")) {
            window.location.replace("../visions/new");
        } else {
            // Stay on the page to user save content
        }
    } else {
        window.location.replace("../visions/new");
    }
};