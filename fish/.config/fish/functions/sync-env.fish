#!/usr/bin/env fish

function sync-env --description "Sync .env files to env-sync directory with structured naming"
    # Parsear argumentos nombrados
    argparse 'h/help' 'base-path=' 'sync-path=' -- $argv
    or return
    
    # Mostrar ayuda
    if set -q _flag_help
        echo "Usage: sync-env --base-path PATH --sync-path PATH"
        echo ""
        echo "Required options:"
        echo "  --base-path PATH    Base directory to search for .env files"
        echo "  --sync-path PATH    Directory to save synchronized files"
        echo "  -h, --help          Show this help"
        echo ""
        echo "Example:"
        echo "  sync-env --base-path ~/shared/projects --sync-path ~/shared/env-sync"
        return 0
    end
    
    # Verificar que ambos argumentos estén presentes
    if not set -q _flag_base_path; or not set -q _flag_sync_path
        echo "❌ Error: Both arguments are required"
        echo ""
        echo "Usage: sync-env --base-path PATH --sync-path PATH"
        echo "Use 'sync-env --help' for more information"
        return 1
    end
    
    # Asignar los paths desde los argumentos
    set base_path $_flag_base_path
    set sync_dir $_flag_sync_path
    
    # Expandir tildes en los paths
    set base_path (path resolve $base_path)
    set sync_dir (path resolve $sync_dir)
    
    # Verificar que existe el directorio base
    if not test -d $base_path
        echo "❌ Base directory does not exist: $base_path"
        return 1
    end
    
    # Verificar si el directorio de sync ya existe (ANTES de crearlo)
    set sync_dir_exists false
    if test -d $sync_dir
        set sync_dir_exists true
    end
    
    # Contador de archivos procesados
    set count 0
    
    echo "🔍 Searching for .env files in: $base_path"
    echo "📁 Syncing to: $sync_dir"
    echo ""
    
    # Verificar si rsync está disponible
    if not command -v rsync >/dev/null
        echo "❌ Error: rsync is not installed"
        echo "   Install it with: sudo dnf install rsync"
        return 1
    end
    
    # Crear directorio temporal para estructura de naming
    set temp_dir (mktemp -d)
    
    echo "🔧 Preparing file structure..."
    
    # Buscar todos los .env recursivamente y crear estructura con naming correcto
    for env_file in (find $base_path -name ".env" -type f)
        # Obtener la ruta relativa desde base_path
        set relative_path (string replace $base_path/ "" $env_file)
        
        # Separar proyecto base y subdirectorio
        set path_parts (string split "/" $relative_path)
        
        if test (count $path_parts) -eq 2
            # Caso: ProyectoBase/.env
            set project_base $path_parts[1]
            set new_name "$project_base.env"
        else if test (count $path_parts) -eq 3
            # Caso: ProyectoBase/frontend/.env o ProyectoBase/server/.env
            set project_base $path_parts[1]
            set subdirectory $path_parts[2]
            set new_name "$project_base"_"$subdirectory.env"
        else
            # Casos más profundos: ProyectoBase/some/deep/path/.env
            set project_base $path_parts[1]
            # Unir todos los directorios intermedios con guiones bajos
            set subdirs (string join "_" $path_parts[2..-2])
            set new_name "$project_base"_"$subdirs.env"
        end
        
        # Copiar al directorio temporal con el nuevo nombre
        cp $env_file "$temp_dir/$new_name"
        echo "📝 Prepared: $relative_path → $new_name"
        set count (math $count + 1)
    end
    
    if test $count -eq 0
        echo "⚠️  No .env files found"
        rm -rf $temp_dir
        return 0
    end
    
    echo ""
    echo "🚀 Syncing with rsync..."
    
    # Determinar flags de rsync como array
    set rsync_flags -av
    if test $sync_dir_exists = true
        set rsync_flags $rsync_flags --checksum
        echo "📂 Target directory exists, using --checksum (only modified files)"
    else
        echo "🆕 New target directory, full sync"
    end
    
    # Agregar progreso con info=progress2 (más moderno y confiable)
    set rsync_flags $rsync_flags --info=progress2
    
    # Crear directorio de destino (rsync lo necesita)
    mkdir -p $sync_dir
    
    # Ejecutar rsync con flags como array
    rsync $rsync_flags "$temp_dir/" "$sync_dir/"
    
    # Limpiar directorio temporal
    rm -rf $temp_dir
    
    echo ""
    if test $count -eq 0
        echo "⚠️  No .env files found"
    else
        echo "🎉 Synced $count .env files"
        echo "📂 Files available at: $sync_dir"
    end
end
