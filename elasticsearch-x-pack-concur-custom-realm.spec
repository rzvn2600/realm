# SPEC file for Elasticsearch x-pack extension custom-realm 

# settings
%define target  /opt/elasticsearch/plugins
%define source  %(pwd)/rpmbuild/SOURCES
%define plugin  custom-realm

# get version
%define version %{getenv:VERSION}

# preamble
Summary:     X-pack Extension: %{plugin}
Name:        elasticsearch-x-pack-concur-%{plugin}
Version:     %{version}
Release:     2.cnqr
License:     proprietary
URL:         http://www.elastic.co
BuildArch:   noarch
AutoReqProv: no

%description
This RPM package prepare Elasticsearch x-pack extension %{plugin} into %{target},
to be ready for installation.

%install
mkdir -p %{buildroot}%{target}

cp -a %{source}/%{plugin}-%{version}.zip %{buildroot}%{target}

%files
%defattr(0644,root,root,0755)
%{target}/%{plugin}-%{version}.zip
