Google MobWrite is a "Real-time Synchronization and Collaboration Service".
The original project can be found at http://code.google.com/p/google-mobwrite.
This repository adds a few minor modifications to enable it to run on
DotCloud. It is based on http://github.com/plasticine/google-mobwrite,
which did the really important updates, like enabling MobWrite to run over
WSGI instead of mod_python.

To run this code on DotCloud, you need to `get a (free!) DotCloud account
<https://www.dotcloud.com/accounts/register/>`_. Then::

  git clone git://github.com/jpetazzo/google-mobwrite.git
  cd google-mobwrite
  dotcloud push mobwrite

Feel free to poke around the code. Each time you do some modifications,
you need to git add + git commit your changes, and then repeat the
``dotcloud push mobwrite`` command to push the changes to DotCloud.

**This repository is also a step-by-step tutorial:** each commit
corresponds to one step, with the commit message providing explanations. 

You can view the whole tutorial, and the modified files at each step,
with at least three different methods:

* by using GitHub's awesome `compare view
  <https://github.com/jpetazzo/google-mobwrite/compare/begin...end>`_:
  you will see the list of commits involved in the tutorial, and by
  clicking on each individual commit, you will see the file modifications
  for this step;
* by running ``git log --patch --reverse begin..end`` in your local
  repository, for a text-mode equivalent (with the added benefit of being
  available offline!);
* by browsing a more `traditional version 
  <http://docs.dotcloud.com/tutorials/python/mobwrite/>`_ on DotCloud's
  documentation website.

You can also learn more by diving into `DotCloud documentations
<http://docs.dotcloud.com/>`_, especially the one for the `Python service
<http://docs.dotcloud.com/services/python/>`_ which is used by this app.


