#[derive(Debug)]
struct TreeNode {
    v: i32,
    l: Option<Box<Self>>,
    r: Option<Box<Self>>,
}

impl TreeNode {
    fn with_v(v: i32) -> Self {
        return Self {
            v,
            l: None,
            r: None,
        };
    }

    fn with_vlr(v: i32, l: Option<Box<Self>>, r: Option<Box<Self>>) -> Self {
        return Self { v, l, r };
    }

    fn boxed(n: Self) -> Option<Box<Self>> {
        return Some(Box::new(n));
    }

    fn v(v: i32) -> Option<Box<Self>> {
        return Self::boxed(Self::with_v(v));
    }

    fn vlr(v: i32, l: Option<Box<Self>>, r: Option<Box<Self>>) -> Option<Box<Self>> {
        return Self::boxed(Self::with_vlr(v, l, r));
    }

    fn inorder(root: Option<Box<Self>>, v: &mut Vec<i32>) {
        if root.is_none() {
            return;
        }

        let node = root.unwrap();
        Self::inorder(node.l, v);
        v.push(node.v);
        Self::inorder(node.r, v);
    }

    fn preorder(root: Option<Box<Self>>, v: &mut Vec<i32>) {
        if root.is_none() {
            return;
        }

        let node = root.unwrap();
        v.push(node.v);
        Self::preorder(node.l, v);
        Self::preorder(node.r, v);
    }

    fn postorder(root: Option<Box<Self>>, v: &mut Vec<i32>) {
        if root.is_none() {
            return;
        }

        let node = root.unwrap();
        Self::postorder(node.l, v);
        Self::postorder(node.r, v);
        v.push(node.v);
    }
}

fn main() {
    let t = TreeNode::vlr(
        0,
        TreeNode::vlr(
            1,
            TreeNode::vlr(3, TreeNode::v(7), TreeNode::v(8)),
            TreeNode::vlr(4, TreeNode::v(9), TreeNode::v(10)),
        ),
        TreeNode::vlr(
            2,
            TreeNode::vlr(5, TreeNode::v(11), TreeNode::v(12)),
            TreeNode::vlr(6, TreeNode::v(13), TreeNode::v(14)),
        ),
    );

    println!("{t:#?}")
}
