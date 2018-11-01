:: Setup environment variable
set HOSTNAME=hostname
set port=8080
set AUTHKEY=<auth-key path>
set STREAM=stream

:: Clean output
make clean
del model\output.xmldb
rmdir /s /Q config

cov-configure.exe --config config\coverity_config.xml --gcc

cov-build.exe --dir idir --config config\coverity_config.xml make

:: Analyze without function model
::cov-analyze --dir idir --all --aggressiveness-level high

:: Build function model
cov-make-library.exe -of model\output.xmldb --concurrency model\my_free.c model\my_lock.c
:: Analyze with function model
cov-analyze --dir idir --all --aggressiveness-level high --model-file model\output.xmldb --enable-callgraph-metrics

cov-commit-defects.exe --dir idir --host %HOSTNAME% --port %port% --auth-key-file %AUTHKEY% --stream %STREAM%