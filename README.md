# Intra 42 - iOS Application for 42 Students

> [!NOTE]
> This application is still under development and is therefore not yet present to download from the App Store.

## Introduction

Intra 42 is an iOS app designed to enhance the experience of students at 42.
This app aims to provide 42 students with convenient access to essential information, resources, and tools to streamline their academic journey.

## Feedback and Contributions

We welcome feedback, bug reports, and contributions from the 42 community to help improve the app.
If you encounter any issues or have suggestions for new features, please open an issue on the GitHub repository.

If you'd like to contribute to the development of Intra 42, feel free to fork the repository, make your changes, and submit a pull request.

### Requirements

To run the app, you first need to [create an app for 42's API](https://profile.intra.42.fr/oauth/applications/new) with the following redirection URI : `fr.marcmosca.Intra42://oauth2callback`.

Then create a file in Intra42 folder named `Api.plist` and add your credentials, like that :

- `API_CLIENT_ID` : Correspond to your app client id.
- `API_SECRET_ID` : Correspond to your app secret id.
- `API_REDIRECT_URI` : Correspond to your app redirect uri (so `fr.marcmosca.Intra42://oauth2callback`).

## Disclaimer

This project is not officially affiliated with 42 or any of its official entities.
It is an independent project created by and for 42 students to enhance their experience.
Use this app responsibly and respect the policies and guidelines of 42.

## License

This project is licensed under the GPL-3.0 license.

## Contact me

You can send me an email at **mmosca@student.42lyon.fr**.
