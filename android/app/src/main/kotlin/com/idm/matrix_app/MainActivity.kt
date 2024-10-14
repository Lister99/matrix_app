package com.idm.matrix_app

import android.graphics.Color
import android.os.Bundle
import android.view.View
import com.google.android.material.snackbar.Snackbar
import com.idm.matrix_app.core.constants.Constants
import com.idm.matrix_app.core.dialog.MatrixBottomDialog
import com.idm.matrix_app.model.ErrorMessage
import com.idm.matrix_app.model.MatrixData
import io.flutter.embedding.android.FlutterFragmentActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel


class MainActivity : FlutterFragmentActivity() {

    private lateinit var rootView: View

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        rootView = findViewById(android.R.id.content)
    }

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            Constants.MATRIX_CHANNEL
        ).setMethodCallHandler { call, _ ->
            eventMatrixChannel(call.method, call.arguments)
        }
    }

    private fun eventMatrixChannel(method: String, arguments: Any) {
        when (method) {
            Constants.SHOW_ORIGINAL_MATRIX -> showMatrix(arguments)
            Constants.SHOW_ERROR_MESSAGE_MATRIX -> showErrorMessage(arguments)
        }
    }

    private fun showMatrix(arguments: Any) {
        val matrixData = MatrixData.fromJson(arguments.toString())
        val dialog = MatrixBottomDialog(
            this,
            matrixData.title,
            matrixData.getStringMatrix(),
            matrixData.buttonText
        )
        dialog.show(supportFragmentManager, dialog.tag)
    }

    private fun showErrorMessage(arguments: Any) {
        val message = ErrorMessage.fromJson(arguments.toString())
        val snackbar = Snackbar
            .make(rootView, message.description, Snackbar.LENGTH_SHORT)
        snackbar.duration = message.displayDuration.toInt() * 1000
        val snackbarView = snackbar.view
        snackbarView.setBackgroundColor(Color.RED)
        snackbar.show()
    }
}
