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
    ext_modules=cythonize(extensions, compiler_directives={'language_level' : "3"}), requires=['Cython'] 
)