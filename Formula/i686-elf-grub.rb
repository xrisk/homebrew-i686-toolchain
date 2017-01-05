# Documentation: https://github.com/Homebrew/brew/blob/master/docs/Formula-Cookbook.md
#                http://www.rubydoc.info/github/Homebrew/brew/master/Formula
# PLEASE REMOVE ALL GENERATED COMMENTS BEFORE SUBMITTING YOUR PULL REQUEST!

class I686ElfGrub < Formula
  desc ""
  homepage ""
  sha256 "65b39a0558f8c802209c574f4d02ca263a804e8a564bc6caf1cd0fd3b3cc11e3"

  head "git://git.savannah.gnu.org/grub.git", :using => :git

  depends_on "i686-elf-gcc"
  depends_on "i686-elf-binutils"
  depends_on "flex"
  depends_on "autoconf"
  depends_on "autogen"
  depends_on "automake"
  depends_on "objconv"
  depends_on "xorriso"

  
  def install

	  # ./grub/configure --disable-werror TARGET_CC=i686-elf-gcc TARGET_OBJCOPY=i686-elf-objcopy TARGET_STRIP=i686-elf-strip TARGET_NM=i686-elf-nm TARGET_RANLIB=i686-elf-ranlib --target=i686-elf --prefix=/opt
	  #

	gcc = Formulary.factory "i686-elf-gcc"
	binutils = Formulary.factory "i686-elf-binutils"

	ENV['PATH'] = "#{gcc.opt_bin}:#{binutils.opt_bin}:#{ENV['PATH']}"

	system "./autogen.sh"
	
	mkdir "build" do

		system "../configure", "--disable-werror",
						  "TARGET_CC=i686-elf-gcc",
                          "TARGET_OBJCOPY=i686-elf-objcopy",
						  "TARGET_STRIP=i686-elf-strip",
						  "TARGET_NM=i686-elf-nm",
						  "TARGET_RANLIB=i686-elf-ranlib",
						  "--target=i686-elf",
                          "--prefix=#{prefix}"

		system "make"
		system "make install"
	end
  end

  test do
    # `test do` will create, run in and delete a temporary directory.
    #
    # This test will fail and we won't accept that! It's enough to just replace
    # "false" with the main program this formula installs, but it'd be nice if you
    # were more thorough. Run the test with `brew test i686-grub`. Options passed
    # to `brew install` such as `--HEAD` also need to be provided to `brew test`.
    #
    # The installed folder is not in the path, so use the entire path to any
    # executables being tested: `system "#{bin}/program", "do", "something"`.
    system "false"
  end
end
