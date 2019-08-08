# automatically generated from https://github.com/metwork-framework/resources/blob/master/cookiecutter/%7B%7Bcookiecutter.repo%7D%7D/docker-mfxxx-yyy-testimage_Dockerfile)





ARG BRANCH=master
FROM centos:${OS_VERSION}
ARG BRANCH
RUN echo -e "[metwork_${BRANCH}]\n\
name=Metwork Continuous Integration Branch ${BRANCH}\n\
baseurl=http://metwork-framework.org/pub/metwork/continuous_integration/rpms/${BRANCH}/centos6/\n\
gpgcheck=0\n\
enabled=1\n\
metadata_expire=0\n" >/etc/yum.repos.d/metwork.repo
ARG CACHEBUST=0
RUN yum clean all && yum --disablerepo=* --enablerepo=metwork_${BRANCH} -q list metwork-mfext* 2>/dev/null |sort |md5sum |awk '{print $1;}' > /tmp/yum_cache

FROM centos:${OS_VERSION}
ARG BRANCH
COPY --from=yum_cache /etc/yum.repos.d/metwork.repo /etc/yum.repos.d/
COPY --from=yum_cache /tmp/yum_cache .
RUN yum clean all && yum -y install metwork-mfext-minimal
