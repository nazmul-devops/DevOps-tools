---
sidebar: auto
---

# Jenkins Tutorial

By Nazmul Islam (Swapan) - Junior DevOps Engineer at InNeed Cloud

## What is Jenkins?

Jenkins is an open-source automation server that helps automate various aspects of software development, including building, testing, and deploying software applications. Jenkins is widely used for continuous integration (CI) and continuous delivery (CD) pipelines, which are key practices in modern software development.

Jenkins provides a vast collection of plugins that extend its functionality and enable integration with various third-party tools and services. It also offers a web-based interface that makes it easy to configure and manage jobs and pipelines.

Using Jenkins, developers can automate the process of building and testing their code every time they make changes, which helps detect and fix issues quickly. Jenkins can also automate the process of deploying software to various environments, such as development, testing, and production.

Overall, Jenkins is a powerful tool for automating software development processes and helping teams improve their development workflows.

## Why we should use Jenkins?

Why should we use Jenkins?

There are several reasons why you might consider using Jenkins in your software development process:

1. **Automation:** Jenkins automates various aspects of the software development process, including building, testing, and deployment. This can save you time and reduce the likelihood of human errors.

2. **Flexibility:** Jenkins provides a wide range of plugins that enable integration with various tools and services. This means you can use Jenkins to build and test code written in many different programming languages and deploy to many different environments.

3. **Scalability:** Jenkins can scale to support large development teams and complex software projects. You can use Jenkins to manage multiple pipelines and jobs, distribute builds across multiple agents, and run tests in parallel.

4. **Visibility:** Jenkins provides a web-based interface that makes it easy to monitor the status of builds, tests, and deployments. This can help you quickly identify and fix issues in your code.

5. **Community Support:** Jenkins is an open-source project with a large and active community. This means there are many resources available online, including documentation, tutorials, and support forums.

Overall, Jenkins can help you streamline your software development process, improve code quality, and accelerate time to market.

# Installing Jenkins

Ref: https://www.jenkins.io/doc/book/installing/docker/

## How to install jenkins on ubuntu server.

```sh
sudo apt update

sudo apt install openjdk-8-jdk wget gnupg

curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key | sudo tee \
  /usr/share/keyrings/jenkins-keyring.asc > /dev/null

echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
  https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
  /etc/apt/sources.list.d/jenkins.list > /dev/null

sudo apt update

sudo apt install -y jenkins

sudo systemctl enable jenkins

sudo systemctl start jenkins

sudo systemctl status jenkins
```

## How to install jenkins on Redhat/Rocky Linux server.

```sh
sudo wget -O /etc/yum.repos.d/jenkins.repo \
    https://pkg.jenkins.io/redhat-stable/jenkins.repo

sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key

sudo yum upgrade

# Add required dependencies for the jenkins package

sudo yum install java-11-openjdk

sudo yum install jenkins

sudo systemctl daemon-reload
```

Now open your web browser and navigate to http://your-server-ip:8080. You should see the Jenkins login page.

## How to create jenkins pipeline

Ref: [YouTube Video Tutorial Link](https://www.youtube.com/watch?v=nplH3BzKHPk&t=1s)

**Live DevOps Project for Resume - Jenkins CICD with GitHub Integration**

1. To create a Jenkins freestyle pipeline from a GitHub repository, you can follow these steps:

2. Open Jenkins in your web browser and log in.

3. Click on "New Item" in the left-hand menu.

4. Enter a name for your pipeline and select "Freestyle project" as the project type. Click "OK".

5. Scroll down to the "Source Code Management" section and select "Git" as the repository type.

6. Enter the URL of your GitHub repository in the "Repository URL" field.

7. In the "Credentials" field, select the username and password or SSH key that you will use to authenticate with the repository.

8. Here you must add ssh key on your github setting from your server's public ssh key.

9. In the "Branches to build" field, enter the branch that you want to build.

10. Scroll down to the "Build" section and click "Add build step".

11. Select the type of build step that you want to add, such as "Execute shell" or "Invoke Gradle script".

12. Enter the commands that you want to run in the build step.

13. Click "Save" to save your pipeline.

14. Click "Build Now" to run your pipeline. You should see the status of each build step as it runs.

That's it! You have created a Jenkins freestyle pipeline from a GitHub repository. You can now modify your build steps and rerun your pipeline as needed.

## Jenkins execute shell command for automated docker build and run.

```sh
# Stop the existing container with the same name
docker stop <container_name> || true
docker rm <container_name> || true

# Remove the existing image with the same name
docker rmi <image_name> || true

# Build and run the new container
docker build -t <image_name> .
docker run -itd --name <container_name> -p 8000:8000 <image_name>
```

### How to connect jenkins with guthub webhook for automatic trigger after code push to github main branch.

#### Integrating Jenkins Webhook with GitHub Repo

1. Go to `Settings > Webhooks` in your GitHub project.

2. Click on the `Add webhook` button.

3. Enter the Jenkins webhook URL in the `Payload URL` field. The webhook URL should be in the format `http://<jenkins_server>/github-webhook/`.
4. Optionally, you can specify a secret token for added security.

5. Choose the events that you want to trigger the webhook. For example, you can select `Push events`, `Pull request events`, and `Tag push events`.

6. Click on the `Add webhook` button to save the webhook.

Now that you've set up the webhook on the GitHub repository, you need to configure Jenkins to receive the webhook notifications.

7. In Jenkins, go to "Manage Jenkins" > "Configure System".

8. Scroll down to the "GitHub" section and click the "Advanced" button.

9. In the "GitHub Web Hook" section, check the "Specify another hook URL for GitHub configuration" checkbox.

10. Enter the same URL you used for the "Payload URL" field in the GitHub webhook configuration.

11. Click the "Save" button to save the configuration.

12. In your Jenkins instance, create a new pipeline project or open an existing one.

13. Go to the `Configure` page for the project and scroll down to the `Build Triggers` section.
14. Check the `GitHub hook trigger for GITScm polling` option.

15. Save the project configuration.

Jenkins is now configured to receive webhook notifications from your GitHub repository. When you push changes to the repository, Jenkins will automatically build and test your code. And now, every time a GitHub event is triggered, GitHub will send a webhook to the Jenkins URL specified in the GitHub project settings, and Jenkins will run the pipeline project according to the configured settings.

Note: You may need to configure your Jenkins server to handle incoming webhooks from GitHub. This can be done by installing and configuring the `GitHub Plugin` in your Jenkins instance.
