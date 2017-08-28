wget https://repo.continuum.io/miniconda/Miniconda2-latest-Linux-x86_64.sh -O miniconda.sh
bash miniconda.sh

export PATH="$HOME/miniconda/bin:$PATH"
export VERSION=TRAVIS_TAG 
export BUILD_DIR= /tmp/build
export PKG_NAME=tsfresh

rehash

conda install conda-build
conda install anaconda-client

conda build tsfresh -c conda-forge --old-build-string --output-folder $BUILD_DIR
cd $BUILD_DIR
conda convert $OS/PKG_NAME-$VERSION-0.tar.bz2 -p all
anaconda -t $CONDA_UPLOAD_TOKEN upload -u nbraun -l nightly $BUILD_DIR/*/$PKG_NAME-$VERSION-0.tar.bz2 --force