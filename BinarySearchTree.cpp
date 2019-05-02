/// Data Structures Course 2018-2019
/// Implementation of Binary Search Tree

#include<iostream>

template <typename T>
struct node {
    T data;
    node<T> *left, *right;
};

template <typename T>
class BinaryTree {
private:
    node<T> *root;
    void deleteTree(node<T>* &other);
    void copyNodes(node<T>* &dest, node<T>* const &src);

    void inorder_(node<T>* const &treeRoot) const;
    void insert_(node<T>* &treeRoot, T const &item);
    bool search_(node<T>* &treeRoot, T const &item);
    node<T>* remove_(node<T>* &treeRoot, T const &item);
public:
    // Big four
    BinaryTree();
    ~BinaryTree();
    BinaryTree(BinaryTree<T> const &other);
    BinaryTree& operator=(BinaryTree<T> const &other);

    // Basic BST functions
    void inorder() const;
    void insert(T const &item);
    bool search(T const &item);
    void remove(T const &item);
};

template <typename T>
BinaryTree<T>::BinaryTree() {
    root = NULL;
}

template <typename T>
BinaryTree<T>::~BinaryTree() {
    deleteTree(root);
}

template <typename T>
BinaryTree<T>::BinaryTree(BinaryTree<T> const &other) {
    copyNodes(other);
}

template <typename T>
BinaryTree<T>& BinaryTree<T>::operator=(BinaryTree<T> const &other) {
    if (&other == this) return *this;

    deleteTree(root);
    copyNodes(root, other.root);
}

template <typename T>
void BinaryTree<T>::copyNodes(node<T>* &dest, node<T>* const &src) {
    dest = NULL;
    if (src != NULL){
        dest = new node<T>;
        dest->data = src->data;
        copyNodes(dest->left, src->left);
        copyNodes(dest->right, src->right);
    }
}

template <typename T>
void BinaryTree<T>::deleteTree(node<T>* &treeRoot) {
    if (treeRoot == NULL) {
        return;
    }

    deleteTree(treeRoot->left);
    deleteTree(treeRoot->right);
    delete treeRoot;
    treeRoot = NULL;
}

template <typename T>
void BinaryTree<T>::insert_(node<T>* &treeRoot, T const &item) {
    if (treeRoot == NULL) {
        treeRoot = new node<T>;
        treeRoot->data = item;
        treeRoot->left = treeRoot->right = NULL;
        return;
    }

    if (item < treeRoot->data){
        insert_(treeRoot->left, item);
    } else {
        insert_(treeRoot->right, item);
    }
}

template <typename T>
void BinaryTree<T>::inorder_(node<T>* const &treeRoot) const {
    if (treeRoot == NULL) return;

    inorder_(treeRoot->left);
    std::cout << treeRoot->data << "\n";
    inorder_(treeRoot->right);
}

template <typename T>
bool BinaryTree<T>::search_(node<T>* &treeRoot, T const &item) {
    if (treeRoot == NULL || treeRoot->data == item) {
        return treeRoot;
    }

    if (item < treeRoot->data){
        return search_(treeRoot->left, item);
    } else {
        return search_(treeRoot->right, item);
    }
}

template <typename T>
node<T>* BinaryTree<T>::remove_(node<T>* &treeRoot, T const &item) {
    if (treeRoot == NULL) return NULL;

    if (item < treeRoot->data) {
        treeRoot->left = remove_(treeRoot->left, item);
        return treeRoot;
    } else if (item > treeRoot->data) {
        treeRoot->right = remove_(treeRoot->right, item);
        return treeRoot;
    }

    // is leaf
    if (treeRoot->left == NULL && treeRoot->right == NULL) {
        delete treeRoot;
        treeRoot = NULL;
        return NULL;
    }

    // has right child
    if (treeRoot->left == NULL && treeRoot->right != NULL) {
        node<T> *temp = treeRoot;
        treeRoot = treeRoot->right;
        delete temp;
        return treeRoot;
    }

    // has left child
    if (treeRoot->left != NULL && treeRoot->right == NULL) {
        node<T> *temp = treeRoot;
        treeRoot = treeRoot->left;
        delete temp;
        return treeRoot;
    }

    // has two children
    node<T> *succParent = treeRoot->right;

    // Find successor (the most left node in the right subtree)
    node<T> *succ = treeRoot->right;
    while (succ->left != NULL) {
        succParent = succ;
        succ = succ->left;
    }

    // Delete successor. Since successor is always left child of its parent
    // we can safely make successor's right right child as left of its parent.
    succParent->left = succ->right;

    // Copy Successor Data to root
    treeRoot->data = succ->data;

    // Delete Successor and return root
    delete succ;
    return treeRoot;
}

template <typename T>
void BinaryTree<T>::insert(T const &item) {
    insert_(root, item);
}

template <typename T>
void BinaryTree<T>::inorder() const {
    inorder_(root);
}

template <typename T>
bool BinaryTree<T>::search(T const &item) {
    return search_(root, item);// == NULL ? false : true;
}

template <typename T>
void BinaryTree<T>::remove(T const &item) {
    remove_(root, item);
}

int main() {
    BinaryTree<int> bst;
    bst.insert(50);
    bst.insert(30);
    bst.insert(20);
    bst.insert(40);
    bst.insert(70);
    bst.insert(60);
    bst.insert(80);
    bst.insert(61);

    bst.inorder();

    std::cout << (bst.search(10) ? "found" : "nope") << "\n";
    std::cout << (bst.search(40) ? "found" : "nope") << "\n";
    std::cout << (bst.search(90) ? "found" : "nope") << "\n";

    bst.remove(20);
    bst.remove(50);

    bst.inorder();

    std::cout << (bst.search(50) ? "found" : "nope") << "\n";
    std::cout << (bst.search(60) ? "found" : "nope") << "\n";
    std::cout << (bst.search(61) ? "found" : "nope") << "\n";
    return 0;
}
