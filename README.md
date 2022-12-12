# LGPDjus

<div>
    <a href='https://play.google.com/store/apps/details?id=br.com.jusbrasil.lgpd&pcampaignid=pcampaignidMKT-Other-global-all-co-prtnr-py-PartBadge-Mar2515-1'><img alt='Disponível no Google Play' src='https://play.google.com/intl/en_us/badges/static/images/badges/pt-br_badge_web_generic.png' style="height: 50px" align="center"/></a> <a href="https://apps.apple.com/us/app/lgpdjus/id1576563624?itsct=apps_box_badge&amp;itscg=30200"><img src="https://tools.applemediaservices.com/api/badges/download-on-the-app-store/black/pt-br?size=250x83&amp;releaseDate=1627171200?h=cffe6c4b48ab6dc75dbc0f04b34de8c2" alt="Download on the App Store" style="height: 39px" align="center"></a>
</div>


O aplicativo LGPDJus permite abertura e acompanhamento de solicitações referentes a nova legislação de proteção de dados pessoais (LGPD) referente ao Tribunal de Justiça de Santa de Catarina.

## Requisitos

- SDK Flutter 2.10 ou [FVM](https://fvm.app/)
- XCode >= 13.1
- Android SDK (com a variável de ambiente `ANDROID_SDK_ROOT` definida)
- [Firebase CLI](https://firebase.google.com/docs/cli) (autenticar usando `firebase login`)
- Make


## Instalação

Instalar as dependências
```bash
flutter pub get
# ou caso esteja utilizando FVM
fvm flutter pub get
```

Copiar arquivo de váriaveis de ambiente
```bash
cp .env.default .env # substitua os valores que forem necessários no arquivo .env
```

Baixa arquivos de configuração do Firebase
```bash
make setup_google_services
```

## Execução

```bash
make run
```
