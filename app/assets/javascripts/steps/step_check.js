function checkSwotAttributes() {
    if ($('#field-Força').val() ||
        $('#field-Fraqueza').val() ||
        $('#field-Oportunidade').val() ||
        $('#field-Ameaça').val()) {
        if(confirm("Você deseja prosseguir sem salvar os campos adicionados?")) {
            window.location.replace("../missions/new");
        } else {
            // Stay on the page to user save content
        }
    } else {
        window.location.replace("../missions/new");
    }
};

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

function checkVisionAttributes() {
    if ($('#vision_where_im_going').val() ||
        $('#vision_where_arrive').val() ||
        $('#vision_how_complete_mission').val()) {
        if(confirm("Você deseja prosseguir sem salvar sua visão?")) {
            window.location.replace("../values/new");
        } else {
            // Stay on the page to user save content
        }
    } else {
        window.location.replace("../values/new");
    }
};

function checkCsfAttributes() {
    if ($('#csf_what_makes_me_unique').val() ||
        $('#csf_best_attributes').val() ||
        $('#csf_essential_atributes').val() ||
        $('#csf_health_factors').val()) {
        if(confirm("Você deseja prosseguir sem salvar seus fatores críticos de sucesso?")) {
            window.location.replace("../spheres/new");
        } else {
            // Stay on the page to user save content
        }
    } else {
        window.location.replace("../spheres/new");
    }
};