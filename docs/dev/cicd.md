# What is CI/CD?

**CI** and **CD** stand for continuous integration and continuous delivery/continuous deployment. In very simple terms, CI is a modern software development practice in which incremental code changes are made frequently and reliably. Automated build-and-test steps triggered by CI ensure that code changes being merged into the repository are reliable. The code is then delivered quickly and seamlessly as a part of the CD process. In the software world, the CI/CD pipeline refers to the **automation** that enables incremental code changes from developers’ desktops to be delivered quickly and reliably to production.

# Why is CI/CD important?

**CI/CD** allows organizations to ship software quickly and efficiently. CI/CD facilitates an effective process for getting products to market faster than ever before, continuously delivering code into production, and ensuring an ongoing flow of new features and bug fixes via the most efficient delivery method. After repositories on GitHub or Bitbucket are authorized and added as a project to circleci.com, every code triggers CircleCI runs jobs. CircleCI also sends an email notification of success or failure after the tests complete.

# Why CircleCI?

CircleCI is a continuous integration and continuous deployment platform (*Software as-a-service*) that helps the development teams to release code rapidly and automate the build, test, and deploy.
CircleCI can be configured to run very complex pipelines efficiently with caching, docker layer caching, resource classes and many more.

# How to trigger the CI/CD workflow?

Whenever an commit is pushed to the [remote repository](https://github.com/theodore86/vagrantenv) or an pull request is performed the **CI pipeline** (*outer loop* - push change, CI build, CI test, deployment) is being triggered. The CI pipeline has been configured to automate all the necessary steps in order to validate any new software changes. The CI pipeline feedback will be used by the PR reviewer in order to merge the software changes in the main branch.

Sometimes it is necessary to quickly validate any software changes without waiting for the remote CI pipeline, in such case the same automated steps can be executed locally (*inner loop* - code, build, run, test) inside the development environment:

```bash
tox -e linters
```

# References

- [CircleCI: Continuous Integration and Delivery](https://circleci.com/)
- [DockerHub for CI/CD best practices](https://www.docker.com/blog/best-practices-for-using-docker-hub-for-ci-cd/)
- [CI/CD concepts](https://docs.gitlab.com/ee/ci/introduction/)
- [CI/CD best practices](https://about.gitlab.com/blog/2022/02/03/how-to-keep-up-with-ci-cd-best-practices/)
