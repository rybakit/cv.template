# CV.template

This repository serves as a template for creating personalized CVs in various formats. By following the instructions
below, you can easily generate your own CV using YAML format for your profile information. Happy CV crafting! ✨


## Getting Started

To get started, follow these simple steps:

 1. Follow the [instructions](https://docs.github.com/en/repositories/creating-and-managing-repositories/creating-a-repository-from-a-template)
    in the GitHub documentation to create a new repository based on this one.

 2. Clone the repository you just created to your local machine and navigate to the cloned directory:

    ```bash
    git clone https://github.com/<your-username>/cv.git
    cd cv
    ```

 3. Open the [profile.yml](profile.yml) file and fill in your profile information in YAML format.
    You can include details such as your name, contact information, education, work experience, skills, and more.

 4. Optionally, customize the CV format layouts by modifying the provided templates
    in the [templates](templates) directory.

 5. Once you've filled in your profile information and customized the CV layouts, commit your changes
    and push them to the repository:

    ```bash
    git add .
    git commit -m "Update profile information"
    git push origin master
    ```


## Automatic CV Generation

Whenever you push changes to the repository, GitHub Actions automatically generate CVs in various formats
using your profile details and the available templates. A new release will be created only if there are changes
to the profile information or any template layout, with the updated CVs attached for easy access.

You can customize the name of the generated files by modifying the [ci.yml](.github/workflows/ci.yml) workflow
to set the `CV_FILENAME` variable. For example:

```yaml
env:
   CV_FILENAME: J_Codemaster_CV
```

This configuration will generate files with the name `J_Codemaster_CV.md`, `J_Codemaster_CV.pdf`, and so on.


## Supported Formats and Templates

Currently, there are three available formats for generating CVs: Markdown, HTML, and PDF.
The layout templates are provided in [Jinja](https://jinja.palletsprojects.com/en/3.1.x/) file format:

 * **Markdown**: Located at [cv.md](templates/cv.md).
 * **HTML**: Located at [cv.html](templates/cv.html).
 * **PDF**: Generated from the Markdown template.

Feel free to customize these templates to your needs.


## License

All the source code in this repository is released under the MIT License. See the bundled [LICENSE](LICENSE) file for details.
