from distutils.core import setup
from distutils.extension import Extension
from Cython.Build import cythonize

extensions = [
    Extension(
        "CubeProgrammer_API",
        ["CubeProgrammer_API.pyx"],
        libraries=["CubeProgrammer_API"], language="c++",
        library_dirs=['./api/lib/'],
    )
]
setup(
    name="CubeProgrammer_API",
    version='0.1',
    description='CubeProgrammer_API.py',
    author='Jim Fred',
    author_email='jimfred@jimfred.org',
    ext_modules=cythonize(
        extensions,
        compiler_directives={
            'language_level': "3",
            'always_allow_keywords': True  # https://github.com/cython/cython/issues/2881
        }),
    requires=['Cython']
)