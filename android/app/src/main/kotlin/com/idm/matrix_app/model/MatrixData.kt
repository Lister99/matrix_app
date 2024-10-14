package com.idm.matrix_app.model

import kotlinx.serialization.*
import kotlinx.serialization.json.*

@Serializable
data class MatrixData(val title: String, val buttonText: String, val matrix: List<List<String>>) {

    fun getStringMatrix(): String {
        var result = ""
        for (row in matrix) {
            for (value in row) {
                result += " $value"
            }
            result += "\n"
        }
        return result
    }

    companion object {
        fun fromJson(source: String): MatrixData {
            return Json.decodeFromString<MatrixData>(source)
        }
    }
}