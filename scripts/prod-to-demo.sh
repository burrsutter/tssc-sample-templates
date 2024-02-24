SCRIPTDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )" 

GITSERVER=gitlab-gitlab.apps.cluster-ggzpw.sandbox3006.opentlc.com
QUAYSERVER=quay-j8xvv.apps.cluster-ggzpw.sandbox3006.opentlc.com
for template in $SCRIPTDIR/../templates/*
do
    template=$(realpath $template)
    if [ -d "$template" ]; then
        echo $template
        cd $template
        sed -i s!quay.io/redhat-appstudio!QUAY-IMAGE_REF!g  template.yaml 
        sed -i s!quay.io!$QUAYSERVER!g  template.yaml 
        sed -i s!QUAY-IMAGE_REF!quay.io/redhat-appstudio!g  template.yaml 
        sed -i s!gitlab.com!$GITSERVER!g  template.yaml  
        sed -i 's/argoInstance\: default/argoInstance\: main/g'  template.yaml 
        sed -i 's/namespace: ${{ parameters.namespace}}/namespace: janus-argocd/g'  template.yaml 
    fi
done
