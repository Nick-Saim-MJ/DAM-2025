package pe.edu.upeu.sysventasjpc.data.local.dao

import androidx.room.Dao
import androidx.room.Delete
import androidx.room.Insert
import androidx.room.OnConflictStrategy
import androidx.room.Query
import androidx.room.Update
import kotlinx.coroutines.flow.Flow
import kotlinx.coroutines.flow.StateFlow
import pe.edu.upeu.sysventasjpc.modelo.Marca


@Dao
interface MarcaDao {
    @Query("SELECT * FROM marca")
     fun getAll(): Flow<List<Marca>>

    @Query("select * from marca where id_marca=:id")
     fun getFindById(id:Long):Flow<Marca>

    @Insert(onConflict = OnConflictStrategy.REPLACE)
     fun insert(vararg to: Marca)

    @Insert(onConflict = OnConflictStrategy.REPLACE)
     fun insertAll(to: List<Marca>)

    @Delete
    fun delete(to: Marca)

    @Update
     fun update(to:Marca)

}