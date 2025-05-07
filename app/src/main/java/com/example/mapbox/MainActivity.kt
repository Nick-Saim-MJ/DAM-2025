package com.example.mapbox

import android.os.Bundle
import android.widget.Toast
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.activity.enableEdgeToEdge
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.padding
import androidx.compose.material3.Scaffold
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.runtime.LaunchedEffect
import androidx.compose.ui.Modifier
import androidx.compose.ui.tooling.preview.Preview
import com.example.mapbox.presentation.MapScreen
import com.example.mapbox.ui.theme.MapBoxTheme
import com.example.mapbox.utils.isNetworkAvailable
import com.google.accompanist.permissions.ExperimentalPermissionsApi
import com.google.accompanist.permissions.rememberMultiplePermissionsState

class MainActivity : ComponentActivity() {
    @OptIn(ExperimentalPermissionsApi::class)
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        enableEdgeToEdge()
        setContent {
            val otorgarp = rememberMultiplePermissionsState(permissions =
                listOf(
                    android.Manifest.permission.ACCESS_NETWORK_STATE,
                    android.Manifest.permission.ACCESS_COARSE_LOCATION,
                    android.Manifest.permission.ACCESS_FINE_LOCATION,
                    android.Manifest.permission.CAMERA,
                ))
            LaunchedEffect(true){
                if (otorgarp.allPermissionsGranted){
                    Toast.makeText(this@MainActivity, "Permiso concedido",
                        Toast.LENGTH_SHORT).show()
                }else{if (otorgarp.shouldShowRationale){
                    Toast.makeText(this@MainActivity, "La aplicacion requiereeste permiso",
                        Toast.LENGTH_SHORT).show()
                }else{
                    Toast.makeText(this@MainActivity, "El permiso fue denegado", Toast.LENGTH_SHORT).show()
                }
                    otorgarp.launchMultiplePermissionRequest()
                }
                Toast.makeText(this@MainActivity,
                    "Con:${isNetworkAvailable(this@MainActivity)}",Toast.LENGTH_LONG
                ).show()
            }


            MapScreen()
            /*MapBoxTheme {
                Scaffold(modifier = Modifier.fillMaxSize()) { innerPadding ->
                    Greeting(
                        name = "Android",
                        modifier = Modifier.padding(innerPadding)
                    )
                }
            }*/
        }
    }
}

@Composable
fun Greeting(name: String, modifier: Modifier = Modifier) {
    Text(
        text = "Hello $name!",
        modifier = modifier
    )
}

@Preview(showBackground = true)
@Composable
fun GreetingPreview() {
    MapBoxTheme {
        Greeting("Android")
    }
}