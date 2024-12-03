~~~bash
git -v # Version

git help [comando] # Ayuda y ayuda de [comando]

## Hay que configurar git, sino no te deja hacer commits

cd /home/tu_usuario

git config --global user.name "John Doe" #Nombre
git config --global user.email "john.doe@gmail.com" #Correo
git config --list #Ves la gonfiguracion global. Puedes usar -l

git init ## Incia proyecto en carpeta actual, crea .git, si lo borras se borra el repositorio.

git branch -m <nombre> # Cambiar el nombre de la rama.
git config --global init.defaultbranch main # Cambia nombre por defecto de la rama principal en los proyectos.


git status # Da info de cambios en el repositorio actual.

git add <archivo> # Lo mete en el stager. -A lo mete todo.

git rm --cached <archivo> # Quita algo del add

git commit -m <Comentario> # Mete todo del stager en el repositorio local.

git log [--oneline] [--graph] [--all] # Muestra el historial de commits, --oneline lo simplifica.

git branch <nuevaRama> # Crea rama <nuevarama>.

git branch # Ves las ramas que existen y en la que estas.

git switch/checkout <nuevaRama> # Cambia la rama de trabajo a <nuevaRama>.

git diff <rama> # Ves direrencias entre rama actual y <rama>.

git merge [--no-ff] <nuevaRama> # Mergea rama actual con <nuevaRama> --no-ff obliga a preguntar.

git branch -d <nuevaRama> # Elimina <nuevaRama>.


git remote [-v] # Ver nombre de origen, -v da mas info
git push <destino> <rama> # Envia los datos a <destino> en <rama>
git fetch # Cumbrueba metadatos para ver si hay cambios en origen
fit pull # Trae datos de origen
~~~
[⬅️ Volver al índice](./Index.md)
[⬆️ Volver al README](/README.md)
