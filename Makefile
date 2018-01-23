# Download and RPM pack Elasticsearch x-pack extension custom-realm
# Razvan.Gherlea@Concur.com

# name of the plugin
PLUGIN_NAME  = assignrole-realm

# versions
VERSIONS     = 6.1.1

# dirname for downloaded packages
RPMBUILD     = rpmbuild
SOURCES_DIR  = $(RPMBUILD)/SOURCES

# colors
ifdef JENKINS_SERVER_COOKIE
NO_COLOR    =
OK_COLOR    =
ERROR_COLOR =
WARN_COLOR  =
PKG_COLOR   =
else
NO_COLOR    = \x1b[0m
OK_COLOR    = \x1b[32;01m
ERROR_COLOR = \x1b[31;01m
WARN_COLOR  = \x1b[33;01m
PKG_COLOR   = \x1b[35;01m
endif

# common tools
ECHO        = /bin/echo -e

# list command
ifdef JENKINS_SERVER_COOKIE
LIST = ls -alR
else
LIST = tree -C --noreport
endif

.PHONY: $(VERSIONS) clean help

all: $(VERSIONS)
	@$(ECHO) '\n$(OK_COLOR)OK$(NO_COLOR), look for built package:'
	@$(LIST) $(RPMBUILD)/RPMS/

$(VERSIONS):
	@$(ECHO)
	@$(ECHO) "$(WARN_COLOR)Building v$@ ...$(NO_COLOR)"
	VERSION='$@' rpmbuild -D "_topdir `readlink -f $(RPMBUILD)`" -bb x-pack-concur-$(PLUGIN_NAME).spec
	@$(ECHO)

clean:
	rm -rf $(RPMBUILD)

help:
	@$(ECHO) 'Download and RPM pack Elasticsearch $(PLUGIN_NAME) plugin(s)'
	@$(ECHO) 'Usage: $(OK_COLOR)make$(NO_COLOR)       ... download plugins from $(WARN_COLOR)$(BASE_URL)$(NO_COLOR) and pack it to RPM'
	@$(ECHO) '       $(ERROR_COLOR)make clean$(NO_COLOR) ... remove temporary files ans downloaded packages'
	@$(ECHO) '       make help  ... show this help'
