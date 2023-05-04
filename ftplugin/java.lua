local config = {
    cmd = {
        'java',
        '-Declipse.application=org.eclipse.jdt.ls.core.id1',
        '-Dosgi.bundles.defaultStartLevel=4',
        '-Declipse.product=org.eclipse.jdt.ls.core.product',
        '-Dlog.protocol=true',
        '-Dlog.level=ALL',
        '-Xmx1g',
        '--add-modules=ALL-SYSTEM',
        '--add-opens', 'java.base/java.util=ALL-UNNAMED',
        '--add-opens', 'java.base/java.lang=ALL-UNNAMED',
        "-javaagent:/Users/riley/.local/share/nvim/mason/packages/jdtls/lombok.jar",
        "-Xbootclasspath/a:/Users/riley/.local/share/nvim/mason/packages/jdtls/lombok.jar",
        '-jar',
        '/Users/riley/.local/share/nvim/mason/packages/jdtls/plugins/org.eclipse.equinox.launcher_1.6.400.v20210924-0641.jar',
        '-configuration',
        '/Users/riley/.local/share/nvim/mason/packages/jdtls/config_mac',
        '-data', '/Users/riley/Public/Java/'
    },
    root_dir = require('jdtls.setup').find_root({ '.git', 'mvnw', 'gradlew' }),
    settings = { java = {} },
    init_options = {
        bundles = {},
    }
}
