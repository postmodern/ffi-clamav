#
# ffi-clamav - Ruby FFI bindings for libclamav
#
# Copyright (c) 2012 Hal Brodigan (postmodern.mod3 at gmail.com)
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
#

require 'ffi/clamav/library'
require 'ffi/clamav/types'
require 'ffi/clamav/error'
require 'ffi/clamav/settings'
require 'ffi/clamav/clamav'

require 'time'

module FFI
  module ClamAV
    class Engine < FFI::AutoPointer

      # Enum of {#bytecode_security} values.
      BYTECODE_SECURITY = ClamAV.enum_type(:cl_bytecode_security)

      # Enum of {#bytecode_mode} values.
      BYTECODE_MODE = ClamAV.enum_type(:cl_bytecode_mode)

      #
      # Initializesa a ClamAV engine.
      #
      # @param [#to_ptr] ptr
      #   An optional pointer to an existing ClamAV engine.
      #
      def initialize(ptr=ClamAV.cl_engine_new)
        super(ptr)
      end

      #
      # Frees a ClamAV engine.
      #
      # @param [Engine] ptr
      #   The pointer to the engine.
      #
      def self.release(ptr)
        ClamAV.cl_engine_free(ptr)
      end

      #
      # Creates a copy of the engine's settings.
      #
      # @return [Settings]
      #   The engine's settings.
      #
      def settings
        Settings.new(ClamAV.cl_engine_settings_copy(self))
      end

      #
      # Settings the engine's settings.
      #
      # @param [Settings] other_settings
      #   The new settings to use.
      #
      # @return [true]
      #   The settings were successfully set.
      #
      # @raise [Error]
      #   An error occurred.
      #
      def settings=(other_settings)
        Error.catch { ClamAV.cl_engine_settings_apply(self,other_settings) }
      end

      #
      # The maximum amount of data that can be scanned.
      #
      # @return [Integer]
      #   The `max_scansize` of the engine.
      #
      def max_scansize
        get_field :max_scansize, :number
      end

      #
      # Sets the maximum amount of data that can be scanned.
      #
      # @param [Integer] new_max_scansize
      #   The new {#max_scansize}.
      #
      # @return [Integer]
      #   The new {#max_scansize}.
      #
      def max_scansize=(new_max_scansize)
        set_field :max_scansize, :number, new_max_scansize
      end

      #
      # The maximum file-size that the engine will scan.
      #
      # @return [Integer]
      #   The `max_filesize` of the engine.
      #
      def max_filesize
        get_field :max_filesize, :number
      end

      #
      # Sets the maximum file-size that the engine will scan.
      #
      # @param [Integer] new_max_filesize
      #   The new {#max_filesize}.
      #
      # @return [Integer]
      #   The new {#max_filesize}.
      #
      def max_filesize=(new_max_filesize)
        set_field :max_filesize, :number, new_max_filesize
      end

      #
      # The maximum depth to scan within nested archives.
      #
      # @return [Integer]
      #   The `max_recursion` of the engine.
      #
      def max_recursion
        get_field :max_recursion, :number
      end

      #
      # Sets the maximum depth to scan within nested archives.
      #
      # @param [Integer] new_recursion
      #   The new {#max_recursion}.
      #
      # @return [Integer]
      #   The new {#max_recursion}.
      #
      def max_recursion=(new_max_recursion)
        set_field :max_recursion, :number, new_max_recursion
      end

      #
      # The maximum number of files to scan within an archive.
      #
      # @return [Integer]
      #   The `max_files` of the engine.
      #
      def max_files
        get_field :max_files, :number
      end

      #
      # Sets the maximum number of files to scan within an archive.
      #
      # @param [Integer] new_max_files
      #   The new {#max_files}.
      #
      # @return [Integer]
      #   The new {#max_files}.
      #
      def max_files=(new_max_files)
        set_field :max_files, :number, new_max_files
      end

      #
      # The lowest number of Credit Card numbers found in a file to trigger
      # a detection.
      #
      # @return [Integer]
      #   The `min_cc_count` of the engine.
      #
      def min_cc_count
        get_field :min_cc_count, :number
      end

      #
      # Sets the lowest number of Credit Card numbers found in a file to
      # trigger a detection.
      #
      # @param [Integer] new_min_cc_count
      #   The new {#min_cc_count}.
      #
      # @return [Integer]
      #   The new {#min_cc_count}.
      #
      def min_cc_count=(new_min_cc_count)
        set_field :min_cc_count, :number, new_min_cc_count
      end

      #
      # The lowest number of Social Security Numbers found in a file to trigger
      # a detection.
      #
      # @return [Integer]
      #   The `min_ssn_count` of the engine.
      #
      def min_ssn_count
        get_field :min_ssn_count, :number
      end

      #
      # Sets the lowest number of Social Security Numbers found in a file to
      # trigger a detection.
      #
      # @param [Integer] new_min_ssn_count
      #   The new {#min_ssn_count}.
      #
      # @return [Integer]
      #   The new {#min_ssn_count}.
      #
      def min_ssn_count=(new_min_ssn_count)
        set_field :min_ssn_count, :number, new_min_ssn_count
      end

      #
      # The list of Possibly Unwanted Applications (PUA) to detect.
      #
      # @return [String, nil]
      #   The `pua_categories` of the engine.
      #
      def pua_categories
        get_field :pua_categories, :string
      end

      #
      # Sets the list of Possibly Unwanted Applications (PUA) to detect.
      #
      # @param [String] new_pua_categories
      #   The new {#pua_categories}.
      #
      # @return [String]
      #   The new {#pua_categories}.
      #
      def pua_categories=(new_pua_categories)
        set_field :pua_categories, :string, new_pua_categories
      end

      #
      # The Database options of the engine.
      #
      # @return [Integer]
      #   The `db_options` of the engine.
      #
      def db_options
        get_field :db_options, :number
      end

      #
      # Sets the Database options for the engine.
      #
      # @param [Integer] new_db_options
      #   The new {#db_options}.
      #
      # @return [Integer]
      #   The new {#db_options}.
      #
      def db_options=(new_db_options)
        set_field :db_options, :number, new_db_options
      end

      #
      # The database version of the engine.
      #
      # @return [Integer]
      #   The `db_version` of the engine.
      #
      def db_version
        get_field :db_version, :number
      end

      #
      # The timestamp of the Database.
      #
      # @return [Integer]
      #   The `db_time` of the engine.
      #
      def db_time
        Time.at(get_field(:db_time,:number))
      end
      
      #
      # The maximum amount of data that can be scanned.
      #
      # @return [Integer]
      #   The `ac_only` of the engine.
      #
      def ac_only
        get_field :ac_only, :number
      end

      #
      # Sets the maximum amount of data that can be scanned.
      #
      # @param [Integer] new_max_scansize
      #   The new {#ac_only}.
      #
      # @return [Integer]
      #   The new {#ac_only}.
      #
      def ac_only=(new_ac_only)
        set_field :ac_only, :number, new_ac_only
      end

      #
      # The maximum amount of data that can be scanned.
      #
      # @return [Integer]
      #   The `max_scansize` of the engine.
      #
      def ac_mindepth
        get_field :ac_mindepth, :number
      end

      #
      # Sets the maximum amount of data that can be scanned.
      #
      # @param [Integer] new_max_scansize
      #   The new {#max_scansize}.
      #
      # @return [Integer]
      #   The new {#max_scansize}.
      #
      def ac_mindepth=(new_ac_mindepth)
        set_field :ac_mindepth, :number, new_ac_mindepth
      end

      #
      # The maximum amount of data that can be scanned.
      #
      # @return [Integer]
      #   The `max_scansize` of the engine.
      #
      def ac_maxdepth
        get_field :ac_maxdepth, :number
      end

      #
      # Sets the maximum amount of data that can be scanned.
      #
      # @param [Integer] new_max_scansize
      #   The new {#max_scansize}.
      #
      # @return [Integer]
      #   The new {#max_scansize}.
      #
      def ac_maxdepth=(new_ac_maxdepth)
        set_field :ac_maxdepth, :number,  new_ac_maxdepth
      end

      #
      # The maximum amount of data that can be scanned.
      #
      # @return [Integer]
      #   The `max_scansize` of the engine.
      #
      def tmpdir
        get_field :tmpdir, :string
      end

      #
      # Sets the maximum amount of data that can be scanned.
      #
      # @param [Integer] new_max_scansize
      #   The new {#max_scansize}.
      #
      # @return [Integer]
      #   The new {#max_scansize}.
      #
      def tmpdir=(new_tmpdir)
        set_field :tmpdir, :string, new_tmpdir
      end

      #
      # The maximum amount of data that can be scanned.
      #
      # @return [Integer]
      #   The `max_scansize` of the engine.
      #
      def keeptmp
        get_field :keeptmp, :number
      end

      #
      # Sets the maximum amount of data that can be scanned.
      #
      # @param [Integer] new_max_scansize
      #   The new {#max_scansize}.
      #
      # @return [Integer]
      #   The new {#max_scansize}.
      #
      def keeptmp=(new_keeptmp)
        set_field :keeptmp, :number, new_keeptmp
      end

      #
      # The bytecode security mode.
      #
      # @return [:trust_all, :trust_signed, :trust_nothing]
      #   The `bytecode_security` field of the engine.
      #
      def bytecode_security
        BYTECODE_SECURITY[get_field(:bytecode_security,:number)]
      end

      #
      # Sets the bytecode security mode.
      #
      # @param [:trust_all, :trust_signed, :trust_nothing] new_bytecode_security
      #   The new {#bytecode_security}.
      #
      # @return [:trust_all, :trust_signed, :trust_nothing]
      #   The new {#bytecode_security}.
      #
      def bytecode_security=(new_bytecode_security)
        set_field :bytecode_security, :number, BYTECODE_SECURITY[new_bytecode_security]
      end

      #
      # @return [Integer]
      #   The `bytecode_timeout` field of the engine.
      #
      def bytecode_timeout
        get_field :bytecode_timeout, :number
      end

      #
      # Sets the maximum amount of data that can be scanned.
      #
      # @param [Integer] new_max_scansize
      #   The new {#max_scansize}.
      #
      # @return [Integer]
      #   The new {#max_scansize}.
      #
      def bytecode_timeout=(new_bytecode_timeout)
        set_field :bytecode_timeout, :number, new_bytecode_timeout
      end

      #
      # The bytecode mode of the engine.
      #
      # @return [:auto, :jit, :interpreter, :test, :off]
      #   The `bytecode_mode` field of the engine.
      #
      def bytecode_mode
        BYTECODE_MODE[get_field(:bytecode_mode,:number)]
      end

      #
      # Sets the bytecode mode of the engine.
      #
      # @param [:auto, :jit, :interpreter, :test, :off] new_bytecode_mode
      #   The new {#bytecode_mode}.
      #
      # @return [:auto, :jit, :interpreter, :test, :off]
      #   The new {#bytecode_mode}.
      #
      def bytecode_mode=(new_bytecode_mode)
        set_field :bytecode_mode, :number, BYTECODE_MODE[new_bytecode_mode]
      end

      #
      # Loads signatures from the Database.
      #
      # @param [String] db
      #   The path to the Database directory.
      #
      # @param [Integer] options
      #   Database options.
      #
      # @return [Integer]
      #   The number of signatures loaded.
      #
      # @raise [Error]
      #   An error occurred.
      #
      def load!(db=ClamAV.db_dir,options=0)
        signo = FFI::MemoryPointer.new(:uint)

        Error.catch { ClamAV.cl_load(db,self,signo,options) }

        return signo.read_uint
      end

      def compile!
        ClamAV.cl_engine_compile(self)
      end

      protected

      def get_field(field,type)
        error = FFI::MemoryPointer.new(:int)

        value = case type
                when :string then ClamAV.cl_engine_get_str(self,field,error)
                when :number then ClamAV.cl_engine_get_num(self,field,error)
                end

        if (errno = error.read_int) > 0
          raise(Error,Error::TYPES[errno])
        end

        return value
      end

      def set_field(field,type,value)
        Error.catch do
          case type
          when :string then ClamAV.cl_engine_set_str(self,field,value)
          when :number then ClamAV.cl_engine_set_num(self,field,value)
          else
            raise(TypeError,"field type value must be :string or :number")
          end
        end

        return value
      end

    end
  end
end
