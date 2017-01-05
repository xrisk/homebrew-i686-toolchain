
require 'formula'

class I686ElfGcc < Formula
  homepage 'http://gcc.gnu.org'
  url 'ftp://ftp.gnu.org/gnu/gcc/gcc-6.3.0/gcc-6.3.0.tar.bz2'
  sha256 "f06ae7f3f790fbf0f018f6d40e844451e6bc3b7bc96e128e63b09825c1f8b29f"

  depends_on 'gmp'
  depends_on 'libmpc'
  depends_on 'mpfr'
  depends_on 'i686-elf-binutils'

  keg_only "Conflicts with GCC built for native development."

  def install
    binutils = Formulary.factory 'i686-elf-binutils'



    ENV['PATH'] = "#{binutils.opt_bin}:#{ENV['PATH']}"
	puts ENV['PATH']

    mkdir 'build' do
      system '../configure', '--disable-nls', '--target=i686-elf',
                             "--prefix=#{prefix}",
                             "--enable-languages=c,c++",
                             "--without-headers",
                             "--with-gmp=#{Formula["gmp"].opt_prefix}",
                             "--with-mpfr=#{Formula["mpfr"].opt_prefix}",
                             "--with-mpc=#{Formula["libmpc"].opt_prefix}"
      system 'make all-gcc'
      system 'make install-gcc'
	  FileUtils.ln_sf binutils.prefix/"i686-elf", prefix/"i686-elf"
      system 'make all-target-libgcc'
      system 'make install-target-libgcc'
    end

	def caveats; <<-EOS.undent
		Please export the following to your environment:
		  CC=#{bin}/i686-elf-gcc
		EOS
	end
	
  end
end
