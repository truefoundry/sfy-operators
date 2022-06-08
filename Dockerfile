FROM alpine/helm
WORKDIR /apps
COPY helm-charts  /apps/helm-charts
ARG tfy_github_token
RUN helm repo add private-helm https://raw.githubusercontent.com/truefoundry/helm-charts/gh-pages --username $tfy_github_token --password $tfy_github_token \
    && cd helm-charts \
    && for d in *; do (helm dependency update "$d"); done

# Build the manager binary
FROM quay.io/operator-framework/helm-operator:v1.20.0
ENV HOME=/opt/helm
COPY watches.yaml ${HOME}/watches.yaml
COPY --from=0 /apps/helm-charts  ${HOME}/helm-charts
WORKDIR ${HOME}
