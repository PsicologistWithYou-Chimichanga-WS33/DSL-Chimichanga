workspace "Name" "Description" {
    !impliedRelationships "false"
    !identifiers "hierarchical"
    model {
        PatientUser = person "Patient User" "Person looking to separate an appointment" "Patient"
        MedicalUser = person "Medical User" "Psychologist or psychiatrist with availability" "Medical"
        PsychologistWithYou = softwareSystem "Psychologist With You" "System that allows patients to separate an appointments with psychologists" "Psychologist With You"{
            Database = container "Database" "Stores user information, hashed authentication credentials, access logs, etc." "Oracle Database Schema" "Database"
            WebApplication = container "Web Application" "Delivers the static content and the internet users platform single page application" "Web Application"
            LandingPage = container "Landing Page" "Landing page for the web application" "Web Application"
            MedicalSinglePageApplication = container "Medical Single Page Application" "Provides all the functionalities to psychologist via their web browser." "Web Application" "Single Page"
            PatientSinglePageApplication = container "Patient Single Page Application" "Provides all the functionalities to patient via their web browser." "Web Application" "Single Page"
            Api = container "Api Aplication" "Provides all the functionalities to the web application" "Web Application"
        }
        Email = softwareSystem "Email" "Use registered mail to notify patients" "Web"
        GoogleMaps = softwareSystem "Google Maps" "Use google maps to show the psychologist location" "Web"
        AmazonWebServices = softwareSystem "Amazon Web Services" "Store all the personal information from the users (patients and psychologists)" "Web"
        Zoom = softwareSystem "Zoom" "Application that will allow virtual meetings between patients and psychologists" "Web"
        PatientUser -> PsychologistWithYou "See psycologist schedule can choose hour"
        MedicalUser -> PsychologistWithYou "Can set, create and edit schedule"
        PsychologistWithYou -> Email "Send e-mail using"
        PsychologistWithYou -> GoogleMaps "View address where the appointment will be made"
        PsychologistWithYou -> AmazonWebServices "Get profile information from patients and psychologist"
        PsychologistWithYou -> Zoom "Shows set schedule"
        Email -> PatientUser "Sends e-mail to"
        PsychologistWithYou.WebApplication -> PsychologistWithYou.LandingPage "User view"
        PsychologistWithYou.LandingPage -> PsychologistWithYou.MedicalSinglePageApplication "Delivers to the psychologist's web browser"
        PsychologistWithYou.LandingPage -> PsychologistWithYou.PatientSinglePageApplication "Delivers to the patient's web browser"
        PsychologistWithYou.MedicalSinglePageApplication -> PsychologistWithYou.Api "Makes API call to[JSON/HTTPS]"
        PsychologistWithYou.PatientSinglePageApplication -> PsychologistWithYou.Api "Makes API call to[JSON/HTTPS]"
        PatientUser -> PsychologistWithYou.WebApplication "Visits pyschologistwithyou.com using[HTTPS]"
        MedicalUser -> PsychologistWithYou.WebApplication "Visits pyschologistwithyou.com using[HTTPS]"
        PatientUser -> PsychologistWithYou.PatientSinglePageApplication "View future appointments registered and personal profile from the expert"
        MedicalUser -> PsychologistWithYou.MedicalSinglePageApplication "View patient's information, personal schedule and save notes from the session"
        PsychologistWithYou.Api -> PsychologistWithYou.Database "Reads from and writes to [SQL/TCP]"
        PsychologistWithYou.Api -> Email "Send e-mail using"
        PsychologistWithYou.Api -> GoogleMaps "View address where the appointment will be made"
        PsychologistWithYou.Api -> AmazonWebServices "Get profile information from patients and psychologis"
        PsychologistWithYou.Api -> Zoom "Shows set schedule"
    }
    views {
        systemContext PsychologistWithYou "Contexto" "Diagrama de contexto" {
            include *
            autolayout tb
        }
        container PsychologistWithYou "Container" {
            include *
            include PatientUser
            include MedicalUser
            include Zoom
            include Email
            include GoogleMaps
            include AmazonWebServices
        }
        
        styles {
            element "Container"{
                background "#438DD5"
                color "#ffffff"
            }
            element "Person" {
                shape "Person"
                background "#08427b"
                color "#ffffff"
            }
            element "Database" {
                shape "Cylinder"
                background "#ff0000"
                color "#ffffff"
            }
            element "Psychologist With You" {
                shape "RoundedBox" 
                background "#1168BD"
            }
            element "Single Page" {
                shape "WebBrowser"
                background "#438DD5"
                color "#ffffff"
            }
            element "Web" {
                background "#999999"
                color "#ffffff"
            }
        }
    }

}