package com.idm.matrix_app.model

import kotlinx.serialization.*
import kotlinx.serialization.json.*

@Serializable
data class ErrorMessage(val title: String, val description: String, val displayDuration: Double) {
    companion object {
        fun fromJson(source: String): ErrorMessage {
            return Json.decodeFromString<ErrorMessage>(source)
        }
    }
}