package pe.edu.upeu.sysventasjpc.data.local

import androidx.room.Database
import androidx.room.RoomDatabase
import pe.edu.upeu.sysventasjpc.data.local.dao.MarcaDao
import pe.edu.upeu.sysventasjpc.modelo.Marca

@Database(entities = [Marca::class], version = 1)
abstract class DbDataSource: RoomDatabase() {
    abstract fun marcaDao():MarcaDao
}